//
//  SettingPage.m
//
//  Created by wwl on 12-2-22.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "Globals.h"
#import "RepShowPage.h"
#import <QuartzCore/QuartzCore.h>
#import "ProgressShow.h"
#import "UnitShow.h"
#import "StarcraftBaseUnit.h"
#import "SC2Replay.h"
#import "SC2ReplayUtil.h"
#import "DDFileReader.h"
#import "SBJson.h"
#import "SC2ReplayNode.h"
#import "AppDelegate.h"
#import "ReplaysRunTime.h"

@implementation RepShowPage

//@synthesize repPlayer = _repPlayer;
//@synthesize mapName = _mapName;
//@synthesize fightType = _fightType;
//@synthesize showRace = _showRace;
//
//@synthesize replayName = _replayName;

@synthesize replayData = _replayData;


@synthesize textField = _textField;

@synthesize timeLabel = _timeLabel;
@synthesize supplyStr = _supplyStr;

@synthesize baseTimer = _baseTimer;
@synthesize touchTimer = _touchTimer;

@synthesize dataSource = _dataSource;
@synthesize buildingUnitArray = _buildingUnitArray; //建造中
@synthesize buildedUnitArray = _buildedUnitArray; //建造完毕

@synthesize player = _player;

@synthesize sec = _sec;
@synthesize min = _min;
@synthesize timeKeys = _timeKeys;
@synthesize repLength = _repLength;

@synthesize showActive = _showActive;

@synthesize replay = _replay;

@synthesize hoverView = _hoverView;
@synthesize buildingView = _buildingView;
@synthesize opponentView = _opponentView;

@synthesize titleLabel = _titleLabel;

//@synthesize repShowToolbar = _repShowToolbar;


//@synthesize adView = _adView;

-(void)timeCount{
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    _baseTimer = [NSTimer scheduledTimerWithTimeInterval:gamespeed/theSC2App.theGamespeed target:self selector:@selector(mytimeFire:) userInfo:nil repeats:YES];
    [runLoop run];
//    [self performSelectorOnMainThread:@selector(timeFire) withObject:nil waitUntilDone:NO];
    //[[NSRunLoop currentRunLoop] addTimer:_baseTimer forMode:NSRunLoopCommonModes];
}


-(CATransition *)getUpAnimation{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    return animation;
}


-(void)mainLoop4Time:(int)key{
    NSString *keystr = [NSString stringWithFormat:@"%d",key];
    if ([_replayData objectForKey:keystr]) {
        [_buildingView addUnitInFlow:[_replayData objectForKey:keystr]];
    }
}

- (void)mytimeFire:(NSTimer*)timer{
    _sec++;
    if (_sec == 60){
        _sec = 0;
        _min++;
        if (_min == 60){
            _min = 0;
        }
    }
    _timeKeys = _sec+60*_min;
    _buildingView.timePassed = _timeKeys;
    //根据时间列表做某些动作
//    [self performSelectorOnMainThread:@selector(mainLoop4Time:) withObject:_timeKeys waitUntilDone:NO];
    [self mainLoop4Time:_timeKeys];
    //18分钟后一定结束
    if (_timeKeys == 60*18 || _timeKeys >=_repLength) {
        [timer invalidate];
        timer = nil;
    }
}


-(void)initRepInfoByPlayerTag{
    _replayData = [[SC2ReplayUtil getSc2ReplayUtil] formatListDataByFilePath:_replay.repName];
    _repLength = [[_replayData objectForKey:@"endtime"] intValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    _showActive = false;
    [_baseTimer invalidate];
    _baseTimer = nil;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [_buildingView cleanSelf];
    [_buildingView removeFromSuperview];
}



//为以后预留方法
- (NSString *)checkRaceByRep:(NSString *)Line1{
    return @"";
}


-(void)viewDidLoad{
    
    theSC2App.theGamespeed = 1;
    ReplaysRunTime *runTime = [ReplaysRunTime getRepRunTime];
    [runTime initRepNum];
    //计时开始
    _showActive = false;
    //预载入rep

    self.title = [[NSString alloc]initWithFormat:@"%dX",theSC2App.theGamespeed];
    
    [self initRepInfoByPlayerTag];
    
     NSString *title = [[NSString alloc]initWithFormat:@"%@ %@ %@(%d:%d)",_replay.repPlayer,_replay.fightType,NSLocalizedString(_replay.mapName,nil),(_repLength/60),(_repLength%60)];
    
    _titleLabel.text = title;
    
    //---------------------navi代码------------------
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:
											 [UIImage imageNamed:@"speeddown.png"],
                                             [UIImage imageNamed:@"speedstop.png"], 
											 [UIImage imageNamed:@"speedup.png"],
											 nil]];
	[segmentedControl addTarget:self action:@selector(speedchange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 120, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
	self.navigationItem.rightBarButtonItem = segmentBarItem;
    
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
//                                  initWithTitle:@"Stop"
//                                  style:UIBarButtonItemStyleBordered
//                                  target:self
//                                  action:@selector(doStop)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    //-------------navi代码----------
    
    CGRect frame = _hoverView.frame;
	frame.origin.x = 0;
	frame.origin.y = 0;
	_hoverView.frame = frame;
    _sec = -1;
    _min = 0;
    
    _buildedUnitArray = [[NSMutableArray alloc]init];
    _buildingUnitArray = [[NSMutableArray alloc]init];
    
    
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"BuildingUnitView" owner:self options:nil];
    _buildingView = [nib objectAtIndex:0];
    _buildingView.showRace = _replay.showRace;
    [_buildingView setFrame:CGRectMake(0, 44, 320, 460-44)];
    [self.view addSubview:_buildingView];
    [self.view addSubview:_hoverView];
    [self initAdViewController:CGRectMake(0, 460, 320, 50)]; //广告
}


-(void)showNavi:(BOOL)show{

    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.6];
    
    if (show)
	{
        
        [[self navigationController] setNavigationBarHidden:NO];
        [UIView beginAnimations:@"animateToolBarshow" context:NULL];
        [UIView commitAnimations];
    
        _touchTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(touchTimerFired:) userInfo:nil repeats:NO] ;
		[[NSRunLoop currentRunLoop] addTimer:_touchTimer forMode:NSDefaultRunLoopMode];
	}
	else
	{
        [[self navigationController] setNavigationBarHidden:YES];
        [UIView beginAnimations:@"animateToolBarhide" context:NULL];
        [UIView commitAnimations];
	}
	
	[UIView commitAnimations];
    
}

- (void)showHoverView:(BOOL)show
{
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.40];
	if (show)
	{
		_hoverView.alpha = 1.0;
        [[self navigationController] setNavigationBarHidden:NO];
        [UIView beginAnimations:@"animateToolBarshow" context:NULL];
        [UIView commitAnimations];
	}
	else{
		_hoverView.alpha = 0.0;
        [[self navigationController] setNavigationBarHidden:YES];
        [UIView beginAnimations:@"animateToolBarhide" context:NULL];
        [UIView commitAnimations];
	}
	[UIView commitAnimations];
}

- (void)touchTimerFired:(NSTimer *)timer
{
	// time has passed, hide the HoverView
	[self showNavi: NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLog(@"Opps! touch me!");
    if ([self navigationController].navigationBarHidden == YES) {
        [self showNavi:YES];
    }
}


- (IBAction)startAction:(id)sender{
   // [RepShowToolbar showPanelInView:self.view];
    
//    if (!_repShowToolbar) {
//        _repShowToolbar = [RepShowToolbar showPanelInView:self.view];
//        _repShowToolbar.delegate = self;
//    }
    
	[self showHoverView:NO]; //去除遮罩
    //[_opponentView showTimingView];
    [self doshow];


}


- (IBAction)leftAction:(id)sender{
	[self showHoverView:NO];
    [self doshow];
}

- (IBAction)rightAction:(id)sender
{
	// user touched the right button in HoverView
	[self showHoverView:NO];
}


-(void)doshow{
    _showActive = true;
    //[self timeCount]; //这是在 main loop中
    [_baseTimer invalidate];
    _baseTimer = nil;
    self.title = [[NSString alloc]initWithFormat:@"%dX",theSC2App.theGamespeed];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"repspeed" object:self];
    [NSThread detachNewThreadSelector:@selector(timeCount) toTarget:self withObject:nil];
}

-(void)doSpeedChange{
    [_baseTimer invalidate];
    _baseTimer = nil;
    [NSThread detachNewThreadSelector:@selector(timeCount) toTarget:self withObject:nil];
}


-(void)doStop{
    _showActive = false;
    [_baseTimer invalidate];
    _baseTimer = nil;
    [self showHoverView:YES];
}

-(void)speedchange:(UISegmentedControl *)seg{
    if (_showActive) {
        NSInteger Index = seg.selectedSegmentIndex;
        switch (Index) {
            case 0:
                if (!(theSC2App.theGamespeed <= 1)) {
                    theSC2App.theGamespeed = theSC2App.theGamespeed / 2;
                    [self doSpeedChange];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"repspeed" object:self];
                    self.title = [[NSString alloc]initWithFormat:@"%dX",theSC2App.theGamespeed];
                }
                break;
            case 1:
                [self doStop];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"repstop" object:self];
                self.title = @"STOP";
                break;
            case 2:
                if (!(theSC2App.theGamespeed >= 8)) {
                    theSC2App.theGamespeed = theSC2App.theGamespeed * 2;
                    [self doSpeedChange];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"repspeed" object:self];
                    self.title = [[NSString alloc]initWithFormat:@"%dX",theSC2App.theGamespeed];
                }
            default:
                break;
        }

    }
}

-(void)docancel{
    
//    if([self modelIsStringWithAnyText:_textView.text]){
//        UIAlertView* cancelAlertView = [[UIAlertView alloc] 
//                                        initWithTitle:@"退出"                                                                 
//                                        message:@"确定要关闭?"                                                          
//                                        delegate:self 
//                                        cancelButtonTitle:@"是"
//                                        otherButtonTitles:@"否",                                       nil];
//        
//        [cancelAlertView setTag:2];                                
//        [cancelAlertView show];
//    }else{
        [self dismissModalViewControllerAnimated:YES];
//    }
}


-(void)quitAction{
//    [self docancel];
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
