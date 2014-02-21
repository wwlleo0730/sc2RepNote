//
//  UnitShow.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-28.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "UnitShow.h"
#import "StarcraftBaseUnit.h"

@implementation UnitShow

@synthesize unitNum = _unitNum;
@synthesize unitinfo = _unitinfo;
@synthesize iconView = _iconView;
@synthesize iconBgView = _iconBgView;

-(id)initWithImage:(NSString *)imageName unitNum:(int)unitNum{
     return [self initWithImage:imageName unitNum:unitNum frame:CGRectMake(200,10, 0, 50)];
}

-(id)initWithImage:(NSString *)imageName unitNum:(int)unitNum frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _unitNum = unitNum;
        self.backgroundColor = HEXCOLOR(progressbgcolor);
        
        UIImage *image = [UIImage imageNamed:imageName];
        _iconView = [[UIImageView alloc] initWithImage:image];
        [_iconView setFrame:CGRectMake(0, 0, kLauncherBtnSize, kLauncherBtnSize)];
        [self addSubview:_iconView];
        
        UIImage *iconBg = [UIImage imageNamed:@"icon_bg.png"];
        _iconBgView = [[UIImageView alloc]initWithImage:iconBg];
        [_iconBgView setFrame:CGRectMake(0, 0, kLauncherBtnSize, kLauncherBtnSize)];
        [self addSubview:_iconBgView];
        
        _unitinfo = [[UILabel alloc]initWithFrame:CGRectMake(60,10, 30, 20)];
        _unitinfo.backgroundColor = [UIColor clearColor];
        _unitinfo.textColor = [UIColor whiteColor];
        _unitinfo.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
        _unitinfo.text = [NSString stringWithFormat:@"%d",_unitNum];
        [self addSubview:_unitinfo];
    }
    return self;
}

-(void)setUnitNum:(int)unitNum{
    _unitNum = unitNum;
    _unitinfo.text = [NSString stringWithFormat:@"%d",_unitNum];
}

-(id)initWithTag:(NSString *)tag{
    return [self initWithTag:tag frame:CGRectMake(0 , 0, 70, 70)];
}


-(id)initWithTag:(NSString *)tag frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _unitNum = 0;
//       self.backgroundColor = HEXCOLOR(unitshowbgcolor);
       self.backgroundColor = [UIColor clearColor];
        
        StarcraftBaseUnit *util = [StarcraftBaseUnit getSc2Base];
        UIImage *image = [util UnitImageBytag:tag];
        _iconView = [[UIImageView alloc] initWithImage:image];
        [_iconView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_iconView];
        
//        UIImage *iconBg = [UIImage imageNamed:@"icon_bg.png"];
//        _iconBgView = [[UIImageView alloc]initWithImage:iconBg];
//        [_iconBgView setFrame:CGRectMake(0, 0, kLauncherBtnSize, kLauncherBtnSize)];
//        [self addSubview:_iconBgView];
        
        _unitinfo = [[UILabel alloc]initWithFrame:CGRectMake(33, 33, 30, 15)];
        _unitinfo.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
        _unitinfo.text = [NSString stringWithFormat:@"%d",_unitNum];
        _unitinfo.backgroundColor = [UIColor clearColor];
        _unitinfo.textColor = [UIColor whiteColor];
        [self addSubview:_unitinfo];
    }
    return self;
}


-(void)minusNum{
    _unitNum--;
    _unitinfo.text = [NSString stringWithFormat:@"%d",_unitNum];
}
-(void)addNum{
    _unitNum++;
    _unitinfo.text = [NSString stringWithFormat:@"%d",_unitNum];
}



@end
