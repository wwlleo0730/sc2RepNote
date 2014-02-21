//
//  WarpGateProgressShow.h
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-12.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "ProgressShow.h"

@interface WarpGateProgressShow : ProgressShow

@property (nonatomic,assign) Boolean chronoEffect; //是否被加速
@property (nonatomic,assign) int chronoTime;

-(void)chronoEffected;

@end
