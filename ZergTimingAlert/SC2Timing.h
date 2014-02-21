//
//  SC2Timing.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-4-11.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC2Timing : NSObject

@property (nonatomic,copy) NSString *tag; //标签
@property (nonatomic,copy) NSString *desc; //描述
@property (nonatomic,copy) NSString *descPic; //描述的图片
@property (nonatomic,copy) NSString *timingName; //timing名称
@property (nonatomic,assign) int time; //大概的时间


-(id)initWithInfo:(NSString *)tag desc:(NSString *)desc descpic:(NSString *)descpic timingName:(NSString *)timingName time:(int)time;

@end
