//
//  OppSingleView.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-11.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "OppSingleView.h"

@implementation OppSingleView

@synthesize timingName = _timingName;
@synthesize picView = _picView;
@synthesize timeLine = _timeLine;
@synthesize sc2Time = _sc2Time;
@synthesize during = _during;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)initWithSc2Time:(SC2Timing *)sc2time{
    _sc2Time = sc2time;
    _timingName.text = _sc2Time.timingName;
    _picView.image = [UIImage imageNamed:_sc2Time.descPic];
    _during = _sc2Time.time;
    
//    _timeLine = [[UIView alloc] initWithFrame:CGRectMake(0,150,150,1)];
//    _timeLine.backgroundColor = [[UIColor alloc]initWithRed:0.2 green:0.7 blue:0.1 alpha:0.7];
//    [self addSubview:_timeLine];
}

-(void)showTimeLine{
    [UIView animateWithDuration:_during*2/3
            delay:0.0 
            options:UIViewAnimationOptionCurveEaseOut
            animations:^{
                [_timeLine setFrame:CGRectMake(0, 0, 150, 150)];
            }
            completion:^(BOOL finished) {
                            if (finished) {
    
                             }
                             
                         }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
