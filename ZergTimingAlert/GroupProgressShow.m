//
//  GroupProgressShow.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "GroupProgressShow.h"
#import "ProgressShow.h"
#import "SC2ReplayUtil.h"
#import "StarcraftBaseUnit.h"
#import "Globals.h"
#import "ReplaysRunTime.h"
#import "WarpGateProgressShow.h"

@implementation GroupProgressShow

@synthesize unitArray = _unitArray;
@synthesize numLabel = _numLabel;
@synthesize unitTag = _unitTag;
@synthesize numTag = _numTag;

@synthesize node = _node;

@synthesize delegate = _delegate;
@synthesize iconBgView = _iconBgView;


-(id)initWithUnitTagByNode:(SC2ReplayNode *)repNode frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _numTag = 0;
        _node = repNode;
        _unitTag = repNode.nodeUnit;
        _unitArray = [[NSMutableArray alloc]init];
//        UIImage *iconBg = [UIImage imageNamed:@"icon_bg.png"];
//        _iconBgView = [[UIImageView alloc]initWithImage:iconBg];
//        [_iconBgView setFrame:CGRectMake(0, 0, kLauncherBtnSize, kLauncherBtnSize)];
//        [self addSubview:_iconBgView];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 33, 30, 15)];
        _numLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = [UIColor whiteColor];
        [self addSubview:_numLabel];
    }
    return self;
}

-(void)addNewUnitInGroupByNode{
    ProgressShow *p = NULL;
    if (![_unitTag isEqualToString:@"Protoss Warp Gate"]) {
        p = [[ProgressShow alloc]initWithTag:_unitTag frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }else{
        p = [[WarpGateProgressShow alloc]initWithTag:_unitTag frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    p.delegate = self;
    p.during = [[StarcraftBaseUnit getSc2Base]UnitDuringByNode:_node];
    [_unitArray addObject:p];
    [ self insertSubview:p atIndex:0];
    
    if ([[ReplaysRunTime getRepRunTime]Pfuntion:_unitTag]) {
        [p showstart];
    }
}

-(void)showStart:(ProgressShow *)progress{
    int unitnumAdd = [[StarcraftBaseUnit getSc2Base]UnitAddAfterProduce:_unitTag];
    _numTag+=unitnumAdd;
//     NSLog(@"after showStart %d",_numTag);
    _numLabel.text = [NSString stringWithFormat:@"%d",_numTag];
    [self.delegate unitShowStart:_unitTag];
}



-(void)showEnded:(ProgressShow *) progress{
    [self.delegate addUnitBuilded:_unitTag];
    _numTag = _numTag - 1;
    _numLabel.text = [NSString stringWithFormat:@"%d",_numTag];
    [_unitArray removeObject:progress];
    [progress removeFromSuperview];

    if ([_unitArray count] <= 0) {
        [[ReplaysRunTime getRepRunTime]Vfuntion:_unitTag];
        [self.delegate groupShowEnded:self];
    }
    else if ([_unitArray count] > 0) {
        if ([[ReplaysRunTime getRepRunTime]Vfuntion:_unitTag]) {
            for (ProgressShow *p in _unitArray) {
                if (p.running) {
                    continue;
                }else{
                    if ([[ReplaysRunTime getRepRunTime]Pfuntion:_unitTag]) {
                        [p showstart];
                    }
                    break;
                }
            }
        }
    
    }
}

- (void)willRemoveSubview:(UIView *)subview{
    if ([subview isKindOfClass:[ProgressShow class]]) {
        [((ProgressShow *)subview) doStop];
    }
}

@end
