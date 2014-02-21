//
//  SC2Replay.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-30.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC2Replay : NSObject


@property (nonatomic,strong) NSString *repPlayer; //谁打的
@property (nonatomic,strong) NSString *mapName; //地图
@property (nonatomic,strong) NSString *repInfo; //介绍
@property (nonatomic,strong) NSString *fightType; //对阵
@property (nonatomic,strong) NSString *repStrategy; //策略
@property (nonatomic,strong) NSString *repName; //实际的文件名
@property (nonatomic,strong) NSString *showRace; //展现的种族



@end
