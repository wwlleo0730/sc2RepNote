//
//  OpponentView.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-10.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpponentView : UIView

@property (nonatomic,strong) NSMutableArray *timingArray;


@property (nonatomic,strong) NSMutableArray *showViews;
//-(id)initWithTag:(NSString *)timingTag;
//-(id)initWithTag:(NSString *)timingTag frame:(CGRect)frame;

-(void)showTimingView;
-(id)initWithTiming:(CGRect)frame;

@end
