//
//  SC2Replay.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-30.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "SC2Replay.h"

@implementation SC2Replay

@synthesize repPlayer = _repPlayer;
@synthesize mapName = _mapName;
@synthesize fightType = _fightType;
@synthesize repStrategy = _repStrategy;
@synthesize repInfo = _repInfo;
@synthesize repName = _repName;
@synthesize showRace = _showRace;

-(void)initRepData{
     
}

-(id)init{
    self = [super init];
    if (self) {
        [self initRepData];
    }
    return  self;
}


@end
