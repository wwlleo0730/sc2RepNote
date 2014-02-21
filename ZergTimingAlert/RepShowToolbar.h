//
//  RepShowToolbar.h
//  sc2RepNote
//
//  Created by 文立 吴 on 12-9-5.
//  Copyright (c) 2012年 esse. All rights reserved.
//  for repshowview 


@class RepShowToolbar;
@protocol RepShowToolbarDelegate <NSObject>
@optional

-(void)quitAction;
-(void)speedChange;
-(void)doStopAction;

@end


@interface RepShowToolbar : UIView

@property (nonatomic, strong) IBOutlet UILabel *repSpeedLabel;

@property (nonatomic,assign) id<RepShowToolbarDelegate> delegate;


+(RepShowToolbar *)showPanelInView:(UIView *)view;
+(RepShowToolbar *)showPanelInView:(UIView *)view hideAfter:(NSTimeInterval)interval;

- (void)setup;
- (void)hidePanel;

-(IBAction) backbtnPressed:(id) sender;



@end
