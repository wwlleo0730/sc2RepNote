//
//  WarpGateProgressShow.m
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-12.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "WarpGateProgressShow.h"

@implementation WarpGateProgressShow

@synthesize chronoTime = _chronoTime;
@synthesize chronoEffect = _chronoEffect;

- (void)timeFire:(NSTimer*)theTimer{
    CGFloat addLength = 0.0f;
    if (_chronoEffect) {
        self.passTime = self.passTime+1.5;
        addLength = ((self.iconView.frame.size.width-5)/self.during)*1.5;
        _chronoTime --;
        if (_chronoTime == 0) {
            _chronoEffect = false;
        }
    }
    else{
     self.passTime ++;
        addLength = (self.iconView.frame.size.width-5)/self.during;
    }
    self.showbar.frame = CGRectMake(2, self.iconView.frame.size.height-5, self.showbar.frame.size.width+addLength, 3);
    if (self.passTime >= self.during) {
        [theTimer invalidate];
        theTimer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.delegate showEnded:self];
    }
}


-(void)chronoEffected{
    _chronoEffect = true;
    _chronoTime = 20;
}

@end
