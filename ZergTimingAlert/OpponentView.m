//
//  OpponentView.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-10.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "OpponentView.h"
#import "SC2ReplayUtil.h"
#import "SC2Timing.h"
#import "OppSingleView.h"

@implementation OpponentView

@synthesize timingArray = _timingArray;
@synthesize showViews = _showViews;

///*
// example
// 300pvz 300秒时候pvz的一波出门
// 400pvt 400秒的时候pvt一波出门等等
// */
//-(id)initWithTag:(NSString *)timingTag{
//    return [self initWithTag:timingTag frame:CGRectMake(0 , 0, 70, 70)];
//}
//
//
//-(id)initWithTag:(NSString *)timingTag frame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor darkTextColor];
//        _time = 50;
//        _pic = @"icon-protoss.png";
//        UIImage *image = [UIImage imageNamed:_pic];
//        _iconView = [[UIImageView alloc] initWithImage:image];
//        [_iconView setFrame:CGRectMake(10, 10, frame.size.width-20, frame.size.height-20)];
//        [self addSubview:_iconView];
//    }
//    return self;
//}


-(id)initWithTiming:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
//        self.backgroundColor = [UIColor redColor];
    
        _showViews  = [[NSMutableArray alloc]init];
        SC2ReplayUtil *util = [SC2ReplayUtil getSc2ReplayUtil];
        _timingArray = util.timingArray;
        _showViews = [[NSMutableArray alloc]init];

//        for (SC2Timing *t in _timingArray) {
//            UIView *timingView = [UIView alloc]initWithFrame:<#(CGRect)#>
//        }
        
        for (int i=0; i<[_timingArray count]; i++) {
            SC2Timing *t = [_timingArray objectAtIndex:i];
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"OppSingleView" owner:self options:nil];
            OppSingleView *oppSingleView  = [nib objectAtIndex:0];
            oppSingleView.frame = CGRectMake(5+160*i,0,150,150);
            [oppSingleView initWithSc2Time:t];
            [_showViews addObject:oppSingleView];
            [self addSubview:oppSingleView];
        }
    }
    return self;
}



-(void)showTimingView{
    for (OppSingleView *oppSingleView in _showViews) {
        [oppSingleView showTimeLine];
    }
//    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(5,150,150,1)];
//    v1.backgroundColor = [UIColor greenColor];
//    
//    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(155,150,150,1)];
//    v2.backgroundColor = [UIColor orangeColor];
//    
//    [self addSubview:v1];
//    [self addSubview:v2];

////    UIImageView *firstImageView = [[UIImageView alloc] initWithImage:image];
////    [firstImageView setFrame:CGRectMake(90, 130, 140, 140)];
////    firstImageView.alpha = 0.5;
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,130, 100, 2)];
//    v.backgroundColor = [UIColor greenColor];
//    
//    [self addSubview:v];
//    [UIView animateWithDuration:100
//                          delay:0.0 
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         [v1 setFrame:CGRectMake(5, 0, 150, 150)];
//                         //                         viewToShake.alpha = 1;
//                     }
//                     completion:^(BOOL finished) {
//                         if (finished) {
//                             
//                         }
//                         
//                     }];
    
//    [UIView animateWithDuration:200
//                          delay:0.0 
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         [v2 setFrame:CGRectMake(155, 0, 150, 150)];
//                         //                         viewToShake.alpha = 1;
//                     }
//                     completion:^(BOOL finished) {
//                         if (finished) {
//                             
//                         }
//                         
//                     }];
    
    
}



@end
