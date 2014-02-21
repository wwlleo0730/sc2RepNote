//
//  RepShowToolbar.m
//  sc2RepNote
//
//  Created by 文立 吴 on 12-9-5.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "RepShowToolbar.h"
#import <QuartzCore/QuartzCore.h>

@interface RepShowToolbar ()

@end

@implementation RepShowToolbar


@synthesize repSpeedLabel = _repSpeedLabel;
@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

+(RepShowToolbar *)showPanelInView:(UIView *)view{
    
    return [self showPanelInView:view hideAfter:-1];
}


+(RepShowToolbar *)showPanelInView:(UIView *)view hideAfter:(NSTimeInterval)interval{    
    RepShowToolbar *panel = [RepShowToolbar infoPanel];
    CGFloat panelHeight = 50;   // panel height when no subtitle set
    
    // update frame of panel
    panel.frame = CGRectMake(0, 0, view.bounds.size.width, panelHeight);
    [view addSubview:panel];
    
//    if (interval > 0) {
//        [panel performSelector:@selector(hidePanel) withObject:view afterDelay:interval]; 
//    }
    
    return panel;
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private
////////////////////////////////////////////////////////////////////////

+(RepShowToolbar *)infoPanel {
    RepShowToolbar *panel =  (RepShowToolbar*) [[[UINib nibWithNibName:@"RepShowToolbar" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromBottom;
	[panel.layer addAnimation:transition forKey:nil];
    
    return panel;
}



- (void)setup {
//    self.onTouched = @selector(hidePanel);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}



-(void)hidePanel {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromTop;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height); 
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}


-(IBAction) backbtnPressed:(id) sender{
    [_delegate quitAction];
}


@end
