//
//  ProgressShow.h
//  ZergTimingAlert
//
//  Created by wwl on 12-3-23.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIProgressBar;
@class ProgressShow;

@protocol ProgressShowDelegate <NSObject>
@optional
////显示结束调用
-(void)showEnded:(ProgressShow *) progress;
-(void)showStart:(ProgressShow *) progress;
//-(void)showEnded;
@end



@interface ProgressShow : UIView

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIView *showbar;
@property (nonatomic,assign) int during;
@property (nonatomic,strong) UILabel *infoTime;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) double passTime;

@property (nonatomic,assign) Boolean running;

@property (nonatomic, assign) id <ProgressShowDelegate> delegate;


-(id)initWithImage:(NSString *)imageName during:(float)during;
-(id)initWithImage:(NSString *)imageName during:(float)during frame:(CGRect)frame;


-(id)initWithTag:(NSString *)tag;
-(id)initWithTag:(NSString *)tag frame:(CGRect)frame;

-(void)showstart;
-(void)timeFire:(NSTimer*)theTimer;
-(void)doStop;
@end
