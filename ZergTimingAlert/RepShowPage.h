//
//  SettingPage.h
//  zrccbpm
//
//  Created by wwl on 12-2-22.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ProgressShow.h"
#import "BuildingUnitView.h"
#import "OpponentView.h"
#import "HoverView.h"
#import "SC2Replay.h"

#import "AdViewController.h"
#import "MBProgressHUD.h"

@interface RepShowPage : AdViewController


@property (nonatomic,strong) SC2Replay *replay;

@property (nonatomic,strong) NSMutableDictionary *replayData;
@property (nonatomic,strong) NSMutableArray *dataSource; //已经存在的 建筑&兵力
@property (nonatomic,strong) NSMutableArray *buildingUnitArray;//当前建造中的
@property (nonatomic,strong) NSMutableArray *buildedUnitArray;//已经存在的 建筑&兵力


@property (nonatomic,assign) int sec;
@property (nonatomic,assign) int min;

@property (nonatomic,assign) int timeKeys;

@property (nonatomic,assign) int repLength;
@property (nonatomic,assign) BOOL showActive;


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic,strong) UILabel *timeLabel; //经过时间
@property (nonatomic,strong) NSString *supplyStr;//补给


@property (nonatomic,strong) NSTimer *baseTimer; //main记时条
@property (nonatomic,strong) NSTimer *touchTimer;

@property (nonatomic, strong) AVAudioPlayer *player; //音效播放

@property (nonatomic,strong) IBOutlet HoverView *hoverView;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;


@property (nonatomic,strong) BuildingUnitView *buildingView;
@property (nonatomic,strong) OpponentView *opponentView;




//@property (nonatomic,strong) RepShowToolbar *repShowToolbar;


//@property (nonatomic,strong) NSDictionary *replay;


//@property (nonatomic,strong) ADBannerView *adView;


-(void)doshow;


-(void)initRepInfoByPlayerTag;

@end
