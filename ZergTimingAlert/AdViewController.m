//
//  AdViewController.m
//
//  Created by Airfly Pan on 12-3-24.
//

#import <QuartzCore/QuartzCore.h>
#import "AdViewController.h"

@interface AdViewController ()

@end

@implementation AdViewController
//iAd广告
@synthesize iAdView;
@synthesize gAdView;

#pragma mark -
#pragma mark 定义私有变量
//iAd广告
static int  iAdFailedCount = 0;
static BOOL is_iAdON = NO;
static BOOL is_gAdON = NO;
static BOOL is_gAdFailed = NO;
static BOOL is_iAdWillON = NO; //iAd要显示
static BOOL is_gAdWillON = NO; //Admob要显示
static BOOL isAdLoaded = NO;
static NSString *MY_BANNER_UNIT_ID=@"a14ff142f10df86";
//a14ff142f10df86
//static NSString *air_BANNER_ID = @"123456789";
static CGRect rectAd;

//设备
static BOOL isiPad = NO;
static CGFloat iOSVer = 4.0f;

#pragma mark -
#pragma mark - iAd广告代理
// Cancels the current in-progress banner view action. This should only be used in cases where the 
// user's attention is required immediately.
- (void)cancelBannerViewAction {
//    NSLog(@"[iAd]: Banner已经取消!");
}

//成功加载广告
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
//    NSLog(@"[iAd]: 广告已经加载.");
    if (!is_iAdON)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        is_iAdON = YES;
		banner.hidden = NO;
    }
    isAdLoaded = YES;
}

//加载广告失败
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
//     NSLog(@"iAd failed");
	if(is_iAdON)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 0-banner.frame.size.height);
        [UIView commitAnimations];
        is_iAdON = NO;
		banner.hidden = YES;
    }
    
    iAdFailedCount++;
    
    if(iAdFailedCount == 2) {
        //某次加载失败后，是否会继续试图加载广告？
        //已经确认，某次失败后，仍然会继续加载广告，所以没有必要删除广告层
        //可以考虑iAd广告调用失败3次(指定次数)后开启AdMob广告
        [iAdView removeFromSuperview];
        iAdView.delegate = nil;
        iAdView = nil;
        iAdFailedCount = 0;
        is_iAdON = NO;
        isAdLoaded = NO;
        [self tryGAdWheniAdFailed];
    }
}

//点击广告，进入广告画面
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {   
    return YES;
}

//从广告画面回到程序界面中
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}

#pragma mark -
#pragma mark - Google Admob Ads
// Sent when an ad request loaded an ad.  This is a good opportunity to add this
// view to the hierarchy if it has not yet been added.  If the ad was received
// as a part of the server-side auto refreshing, you can examine the
// hasAutoRefreshed property of the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    NSLog(@"[GAd]: 广告已经加载.");
    if (!is_gAdON)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        view.frame = CGRectOffset(view.frame, 0, -50);
        [UIView commitAnimations];
        is_gAdON = YES;
        is_gAdFailed = NO;
        isAdLoaded = YES;
		view.hidden = NO;
    }
}

// Sent when an ad request failed.  Normally this is because no network
// connection was available or no ads were available (i.e. no fill).  If the
// error was received as a part of the server-side auto refreshing, you can
// examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"GAD didFailToReceiveAdWithError");
    //关闭AdMob
    if(is_gAdON) {
        is_gAdON = NO;
        gAdView.delegate = nil;
        [gAdView removeFromSuperview];
    }
    gAdView = nil;
    isAdLoaded = NO;
    
    //做一次失败尝试
    if(!is_gAdFailed) {
        is_gAdFailed = YES;
        [self tryiAdWhenGAdFailed];
    }
}

// Sent just before presenting the user a full screen view, such as a browser,
// in response to clicking on an ad.  Use this opportunity to stop animations,
// time sensitive interactions, etc.
//
// Normally the user looks at the ad, dismisses it, and control returns to your
// application by calling adViewDidDismissScreen:.  However if the user hits the
// Home button or clicks on an App Store link your application will end.  On iOS
// 4.0+ the next method called will be applicationWillResignActive: of your
// UIViewController (UIApplicationWillResignActiveNotification).  Immediately
// after that adViewWillLeaveApplication: is called.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
//    NSLog(@"[GAD]: 即将显示全屏广告.");
}

// Sent just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
//    NSLog(@"[GAD]: 即将退出全屏广告.");
}

// Sent just after dismissing a full screen view.  Use this opportunity to
// restart anything you may have stopped as part of adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
//    NSLog(@"[GAD]: 全屏广告已经退出.");
}

// Sent just before the application will background or terminate because the
// user clicked on an ad that will launch another application (such as the App
// Store).  The normal UIApplicationDelegate methods, like
// applicationDidEnterBackground:, will be called immediately before this.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
//    NSLog(@"[GAD]: 即将进入广告目标.");
}

#pragma mark -
#pragma mark - Ads广告相关处理
- (BOOL)isiAdSupported {
    bool result = NO;
    
    if(isiPad && iOSVer >= 4.2f)
        result = YES;
    else if((!isiPad) && iOSVer >= 4.0f)
        result = YES;
    
    return result;
}

- (BOOL)isiAdAvailable {
    bool result = NO;
    //获取当前时区设置
    //NSTimeZone *localTZ = [NSTimeZone localTimeZone];
    //[localTZ name];
    //如果是北美国时间或太平洋时间，则假想是美国用户
    //2010.12 英国，法国
    //2011.1  德国
    //2011.?  日本
    //NSTimeZone *my = [NSTimeZone localTimeZone];
    //NSLog(@"%@",[[NSTimeZone localTimeZone] name]);
    //if([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location == 0
    //   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location == 0
    //   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/London"].location == 0
    //   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/Paris"].location == 0
    //   || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/Berlin"].location == 0)
    
//    NSLog(@">>>%@",[[NSTimeZone localTimeZone]name]);
    if([self isiAdSupported] 
       && ([[[NSTimeZone localTimeZone] name] rangeOfString:@"America/"].location == 0
           || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Pacific/"].location == 0
           || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Europe/"].location == 0
           || [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Tokyo"].location == 0))
    {
        result = YES;
    }
    
    //测试iAd
//    result = YES;
    return result;
}

- (void)planAds {
//    NSLog(@"start to Load ad");
	is_iAdWillON = NO;
	is_gAdWillON = NO;
	//分析设备可显示哪一家广告
    //iPhone 4.0开始支持iAd,iPad 4.2才支持iAd
	if([self isiAdAvailable])
        is_iAdWillON = YES;
	else
		is_gAdWillON = YES;
	
	//打开广告
	if(is_gAdWillON || is_iAdWillON) {
		if(is_gAdWillON) {
			//启用AdMob
            if(gAdView) {
                gAdView.delegate = nil;
                [gAdView removeFromSuperview];
                gAdView = nil;
            }
            
			if(!gAdView) {
                
                gAdView = [[GADBannerView alloc] initWithFrame:rectAd];
                gAdView.adUnitID = MY_BANNER_UNIT_ID;
                gAdView.rootViewController = self;
                gAdView.delegate = self;
                GADRequest *GAdRequest = [GADRequest request];
//                GAdRequest.testing = YES;
                [gAdView loadRequest:GAdRequest];
                [self.view addSubview:gAdView];
                gAdView.hidden = YES;
                //NSLog(@"[GAD]: 已经申请广告");
			}
		}
		else {
			//启用iAd
            if(iAdView) {
                iAdView.delegate = nil;
                [iAdView removeFromSuperview];
                iAdView = nil;
            }
            
			if(!iAdView) {
				iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
				
                iAdView.requiredContentSizeIdentifiers = [NSSet setWithObject: ADBannerContentSizeIdentifierPortrait];
                iAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
                iAdView.frame = rectAd;
				iAdView.delegate = self;
				[self.view addSubview:iAdView];
				iAdView.hidden = YES; //暂时不显示广告框，收到广告后再显示出来
			}
		}
	}
	else {
		//关闭广告
		if(gAdView) { // && is_gAdFailed) {  //(gAdView && is_gAdFailed)
			if(is_gAdON) {
                is_gAdON = NO;
                gAdView.delegate = nil;
                [gAdView removeFromSuperview];
            }
			gAdView = nil;
		}
		else if(iAdView) {
			//关闭iAd
			if(is_iAdON) {
				[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
                iAdView.frame = CGRectOffset(iAdView.frame, 0, 0-iAdView.frame.size.height);
				[UIView commitAnimations];
				is_iAdON = NO;
				iAdView.hidden = YES;
			}
            iAdView.delegate = nil;
			[iAdView removeFromSuperview];
			iAdView = nil;
		}
	}
}

- (void)destroyAds {
    if(gAdView) {
        gAdView.delegate = nil;
        [gAdView removeFromSuperview];
        gAdView = nil;
    }
    
    if(iAdView) {
        iAdView.delegate = nil;
        [iAdView removeFromSuperview];
        iAdView = nil;
    }
        
    iAdFailedCount = 0;
    is_iAdON = NO;
    is_gAdON = NO;
    is_gAdFailed = NO;
    is_iAdWillON = NO; //iAd要显示
    is_gAdWillON = NO; //Admob要显示
    isAdLoaded = NO;
}

- (void)tryiAdWhenGAdFailed {
//    NSLog(@"in tryiAdWhenGAdFailed");
    is_gAdFailed = YES;
    is_iAdWillON = [self isiAdSupported];
	
	//打开广告
	if(is_iAdWillON) {
		//启用iAd
        if(gAdView) {
            gAdView.delegate = nil;
            [gAdView removeFromSuperview];
            gAdView = nil;
        }
        
		if(!iAdView) {
			iAdView = [[ADBannerView alloc] initWithFrame:CGRectZero];
            iAdView.requiredContentSizeIdentifiers = [NSSet setWithObject: ADBannerContentSizeIdentifierPortrait];
            iAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
            iAdView.frame = rectAd;
			iAdView.delegate = self;
			[self.view addSubview:iAdView];
			iAdView.hidden = YES; //暂时不显示广告框，收到广告后再显示出来
		}		
	}
}

- (void)tryGAdWheniAdFailed {
//    NSLog(@"in tryGAdWheniAdFailed");
    iAdFailedCount = 0;
    is_gAdWillON = YES;
	
	//打开广告
	if(is_gAdWillON) {
        if(iAdView) {
            iAdView.delegate = nil;
            [iAdView removeFromSuperview];
            iAdView = nil;
        }
		//启用AdMob
        if(!gAdView) {
            gAdView = [[GADBannerView alloc] initWithFrame:rectAd];
            gAdView.adUnitID = MY_BANNER_UNIT_ID;
            gAdView.rootViewController = self;
            gAdView.delegate = self;
            GADRequest *GAdRequest = [GADRequest request];
//            GAdRequest.testing = YES;
            [gAdView loadRequest:GAdRequest];
            [self.view addSubview:gAdView];
            gAdView.hidden = YES;
        }
	}
}

-(void)initAdViewController:(CGRect)adviewFrame{
    rectAd = adviewFrame; 
    MY_BANNER_UNIT_ID = @"a14c00b2b7c0c11"; //admob编号
    [self destroyAds];
    [self planAds];
}

-(void)initAdViewController{
//    sizeScreen = self.view.bounds.size;
    rectAd = CGRectMake(0, 416, 320, 50); //ipod iphone上默认
    MY_BANNER_UNIT_ID = @"a14c00b2b7c0c11"; //admob编号
	//设置iAd广告
    [self destroyAds];
	[self planAds];
}

//------------------air Ad--------------------------------
//
//- (void)setUpAirAD{
//    //设置是否显示提示信息。方便开发调试。
//    [airADView setDebugMode:DEBUG_OFF];
//    //设置是否需要取得GPS信息，为得到高质量的广告，建议打开。
//    [airADView setGPSMode:GPS_OFF];
//}
//
//- (void)setUpADView:(airADView*)adView{
//    //是否需要显示airAD背景。
//    [adView setBannerBGMode:BannerBG_ON];
//    //设置刷新时必须大于15。单位秒。
//    [adView setIntervalTime:30];
//    //设置刷新模式，自动或者手动。设置为手动，则刷新时间的设置无效,并且需要每次主动调用refreshAd。
//    [adView setRefreshMode:REFRESH_MODE_AUTO];
//}
//#define StatusBarHeight 20
//- (CGRect)frameForBanner{
//    CGRect rect = CGRectZero;
//    rect.origin.x = 0;
//    rect.origin.y = 410;
//    return rect;
//}
//
//- (void)addAirADView{
//    airADBanner = [[airADView alloc] init];
//    //您可以设置Frame中的x与y的值，将广告条放在您喜欢的位置。设置width与height无效。
//    [airADBanner setFrame:[self frameForBanner]];
//    //设置Delegate，可以得到对应的一些反馈信息.
//    [airADBanner setDelegate:self];
//    //这里你可以针对当前adView进行设置。可以直接跳过。
//    [self setUpADView:airADBanner];
//    //将airADView添加到您的view之后，就可以通过调用refreshAd方法，开始广告请求
//    [self.view addSubview:airADBanner];
//    [airADBanner refreshAd];
//}
//- (void)removeAirADView{
//    [airADBanner removeFromSuperview];
//    airADBanner = nil;
//}
//
////如何添加Admob
//- (void)airADView:(airADView *)view didFailToReceiveAdWithError:(NSError *)error{
//    if ([error code] == kAErrorIPIllegal) {
//        [self removeAirADView];
//        [self initAdViewController];
//    }
//}
//
//
//-(void)startAirAd{
//    [airADView setAppID:@"123456789"];
//    //这里你可以针对airAD进行全局设置。可以直接跳过。
//    [self setUpAirAD];
//    //直接添加airADView到你想要的view中
//    [self addAirADView];
//}
//
#pragma mark -
#pragma mark 程序生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
//    [self initAdViewController];
}


@end
