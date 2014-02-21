//
//  UnitShow.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-28.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitShow : UIView

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIImageView *iconBgView;

@property (nonatomic,strong) UILabel *unitinfo;
@property (nonatomic,assign) int unitNum; 


-(id)initWithImage:(NSString *)imageName unitNum:(int)unitNum frame:(CGRect)frame;
-(id)initWithImage:(NSString *)imageName unitNum:(int)unitNum;


-(id)initWithTag:(NSString *)tag;
-(id)initWithTag:(NSString *)tag frame:(CGRect)frame;

-(void)minusNum;
-(void)addNum;

@end
