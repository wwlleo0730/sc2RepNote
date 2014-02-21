//
//  ViewController.h
//  Hello Airfly
//
//  Created by Airfly Pan on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//Ads
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

@interface AdViewController : UIViewController<ADBannerViewDelegate,GADBannerViewDelegate> {
    
	//Ads
	ADBannerView *iAdView; //iAd
	GADBannerView *gAdView; //admob
//    airADView *airADBanner;//airAd
}

//iAd广告
@property(nonatomic,retain) ADBannerView *iAdView;
@property(nonatomic,retain) GADBannerView *gAdView;


//- (GADRequest *)createRequest;
-(void)initAdViewController;

-(void)initAdViewController:(CGRect)adviewFrame;

//广告处理
- (BOOL)isiAdSupported;
- (BOOL)isiAdAvailable;
- (void)planAds;
- (void)destroyAds;
- (void)tryiAdWhenGAdFailed;
- (void)tryGAdWheniAdFailed;

//iAd代理
- (void)cancelBannerViewAction;
- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave;
- (void)bannerViewActionDidFinish:(ADBannerView *)banner;
@end
