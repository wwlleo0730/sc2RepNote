//
//  GroupProgressShow.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressShow.h"
#import "StarcraftBaseUnit.h"
#import "SC2ReplayNode.h"

@class GroupProgressShow;
@protocol GroupProgressShowDelegate <NSObject>
@optional
////显示结束调用
-(void)groupShowEnded:(GroupProgressShow *) group;
-(void)addUnitBuilded:(NSString *)unitTag;
-(void)deleteUnitunBuilded;

-(void)unitShowStart:(NSString *)unitTag;

@end


@interface GroupProgressShow : UIView<ProgressShowDelegate>

@property (nonatomic,strong) NSMutableArray *unitArray;//当前建造中的
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) NSString *unitTag;
@property (nonatomic,strong) SC2ReplayNode *node;
@property (nonatomic,assign) int numTag;

@property (nonatomic,strong) UIImageView *iconBgView;
@property (nonatomic, assign) id <GroupProgressShowDelegate> delegate;

-(id)initWithUnitTagByNode:(SC2ReplayNode *)repNode frame:(CGRect)frame;
-(void)addNewUnitInGroupByNode;


@end
