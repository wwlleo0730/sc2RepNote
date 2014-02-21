//
//  SC2Timing.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-11.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "SC2Timing.h"

@implementation SC2Timing

@synthesize time = _time,timingName= _timingName,desc=_desc,descPic=_descPic,tag=_tag;

-(id)initWithInfo:(NSString *)tag desc:(NSString *)desc descpic:(NSString *)descpic timingName:(NSString *)timingName time:(int)time{
    
    self = [super init];
    if (self) {
        _tag = tag;
        _desc = desc;
        _descPic = descpic;
        _time = time;
        _timingName = timingName;
    }
    return self;
}

@end
