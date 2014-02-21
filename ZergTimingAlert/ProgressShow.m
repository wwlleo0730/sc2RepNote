//
//  ProgressShow.m
//  ZergTimingAlert
//
//  Created by wwl on 12-3-23.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "ProgressShow.h"
#import "StarcraftBaseUnit.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ReplaysRunTime.h"

@implementation ProgressShow

@synthesize showbar = _showbar;
@synthesize iconView = _iconView;
@synthesize during = _during;
@synthesize infoTime = _infoTime;
@synthesize timer = _timer;
@synthesize passTime = _passTime;

@synthesize running = _running;

@synthesize delegate = _delegate;

-(id)initWithTag:(NSString *)tag{
    return [self initWithTag:tag frame:CGRectMake(0 , 0, 70, 70)];
}


-(id)initWithTag:(NSString *)tag frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        StarcraftBaseUnit *util = [StarcraftBaseUnit getSc2Base];
        _passTime = 0;
        _running = false;
//        self.backgroundColor = HEXCOLOR(progressbgcolor);
        self.backgroundColor = [UIColor clearColor];
        _during = 15;
        UIImage *image = [util UnitImageBytag:tag];
        _iconView = [[UIImageView alloc] initWithImage:image];
        [_iconView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_iconView];
        _showbar = [[UIView alloc] initWithFrame:CGRectMake(2, frame.size.height-5, 1, 3)];
        _showbar.backgroundColor = [UIColor greenColor];
        [self addSubview:_showbar];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(speedchange)
         name:@"repspeed"
         object:nil];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(doStop)
         name:@"repstop"
         object:nil];
    }
    return self;
}



-(id)initWithImage:(NSString *)imageName during:(float)during{
   return [self initWithImage:imageName during:during frame:CGRectMake(0 , 0, 70, 70)];
}

-(id)initWithImage:(NSString *)imageName during:(float)during frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _passTime = 0;
        _during = during;
        self.backgroundColor = [UIColor darkGrayColor];
        UIImage *image = [UIImage imageNamed:imageName];
        _iconView = [[UIImageView alloc] initWithImage:image];
        [_iconView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_iconView];
        _showbar = [[UIView alloc] initWithFrame:CGRectMake(2, frame.size.height-5, 1, 3)];
        _showbar.backgroundColor = [UIColor greenColor];
        [self addSubview:_showbar];
    }
    return self;
}

- (void)timeFire:(NSTimer*)theTimer{
    _passTime ++;
    _showbar.frame = CGRectMake(2, _iconView.frame.size.height-5, _showbar.frame.size.width+ ((_iconView.frame.size.width-5)/_during), 3);
    if (_passTime >= _during) {
        [theTimer invalidate];
        theTimer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.delegate showEnded:self];
    }
}

-(void)reShow{
    _timer = [NSTimer scheduledTimerWithTimeInterval:gamespeed/theSC2App.theGamespeed target:self selector:@selector(timeFire:) userInfo:_timer repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];   
}


-(void)showstart{
    _running = true;
    [self.delegate showStart:self];
    _timer = [NSTimer scheduledTimerWithTimeInterval:gamespeed/theSC2App.theGamespeed target:self selector:@selector(timeFire:) userInfo:_timer repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];   
}


-(void)doStop{
    [_timer invalidate];
    _timer = nil;
}


- (void)speedchange{
    if (_running) {
       [self doStop];
       [self reShow];
    }
}


@end
