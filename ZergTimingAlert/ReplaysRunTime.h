//
//  ReplaysRunTime.h
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-3.
//  Copyright (c) 2012年 esse. All rights reserved.
//  记录一个replay运行期间需要关注的pv状态
//  例如只有一个基地 则只允许造一个农民

#import <Foundation/Foundation.h>

@interface ReplaysRunTime : NSObject

@property (assign, nonatomic) int baseNum; //建造完成的基地


@property (assign, nonatomic) int barracksNum; //人族兵营数量 暂时不考虑
@property (assign, nonatomic) int factoryNum; //人族工厂数量

+(ReplaysRunTime *)getRepRunTime;
-(void)initRepNum;
-(void)plusBaseNum:(NSString *)tag;

-(Boolean)Pfuntion:(NSString *)tag;
-(Boolean)Vfuntion:(NSString *)tag;

@end
