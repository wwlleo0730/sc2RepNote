//
//  SC2ReplayNode.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-6-3.
//  Copyright (c) 2012年 esse. All rights reserved.
//  replay内的节点

#import <Foundation/Foundation.h>

@interface SC2ReplayNode : NSObject

@property (nonatomic,strong) NSString *nodeType; //节点类型，可能是train，update或者build
@property (nonatomic,strong) NSString *actionTarget; //train没有该
@property (nonatomic,strong) NSString *happenTime; //发生时间
@property (nonatomic,strong) NSString *nodeUnit;//具体信息


- (id) initWithFileLine:(NSString *)actionline;



@end
