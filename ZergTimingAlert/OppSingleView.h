//
//  OppSingleView.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-11.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SC2Timing.h"

@interface OppSingleView : UIView

@property(nonatomic,strong) IBOutlet UILabel *timingName;
@property(nonatomic,strong) IBOutlet UIImageView *picView;

@property(nonatomic,strong) IBOutlet UIView *timeLine;
@property(nonatomic,strong) SC2Timing *sc2Time;
@property(nonatomic,assign) int during;


-(void)showTimeLine;
-(void)initWithSc2Time:(SC2Timing *)sc2time;

@end
