//
//  SC2ReplayNode.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-6-3.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "SC2ReplayNode.h"

@implementation SC2ReplayNode

@synthesize nodeType = _nodeType;
@synthesize happenTime = _happenTime;
@synthesize nodeUnit = _nodeUnit;
@synthesize actionTarget = _actionTarget;


- (id) initWithFileLine:(NSString *)actionline{
    self = [self init];
    if (self) {
        NSArray *listItems = [actionline componentsSeparatedByString:@"|"];
        NSString *time = [listItems objectAtIndex:0];
        
        self.happenTime = time;
        
        NSString *action = [listItems objectAtIndex:1];
        NSArray *actionArr = [action componentsSeparatedByString:@";"];
        
        NSString *act = @""; 
        NSString *actType = @"";
        NSString *actUnit = @"";
        NSString *actTarget = @"";
        
        
        act = [actionArr objectAtIndex:0];
        
    
        if ([actionArr count]==1) {
            //不存在 target选项，说明是train 或者 Research 或者 是zerg的 build lair或者hive
            //或者是zergling变毒爆
            
            if ([act hasPrefix:@"Train"]) {
                actType = @"Train";
                actUnit = [act substringFromIndex:5];
            }else if([act hasPrefix:@"Build"]){
                //Build lair or hive
                //或者人族挂固定附件
                actType = @"Build";
                actUnit = [act substringFromIndex:5];
                actUnit = [actUnit stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSArray *ts = [actUnit componentsSeparatedByString:@"("];
                if ([ts count]>1) {
                    NSString *tar = [[ts objectAtIndex:1]stringByReplacingOccurrencesOfString:@")" withString:@""];
                    actTarget = tar;
                    if([actUnit hasPrefix:@"Reactor"]) {
                        actUnit = @"Reactor";
                    }else if([actUnit hasPrefix:@"Tech Lab"]){
                        actUnit = @"Tech Lab";
                    }else{
                        
                    }
                }
                else{
                    //虫族升2本或者3本
                }
            }else if([act hasPrefix:@"Research"]){
                actType = @"Research";
                actUnit = [act substringFromIndex:8];
            }else if ([act hasPrefix:@"Upgrade"]){
                 actType = @"Upgrade";
                if ([act hasPrefix:@"Upgrade to"]) {
                    //神族兵营开门
                    //人族基地变形
                    actUnit = [act substringFromIndex:10];
                    actUnit = [actUnit stringByReplacingOccurrencesOfString:@"(Command Center)" withString:@""];
                }
                else{
                    actUnit = [act substringFromIndex:7];
                }
            }
            //兵种变形
            else if ([act hasPrefix:@"Morph"]){
                if ([act hasPrefix:@"Morph to Baneling"]) {
                    actType = @"Train";
                    actUnit = @"Baneling";
                }else if([act hasPrefix:@"Morph to Overseer"]){
                    actType = @"Train";
                    actUnit = @"Overseer";
                }
            }
            else if ([act hasPrefix:@"Archon Warp"]){
                actType = @"Train";
                actUnit = @"Archon";
                //Archon Warp (High Templar or Dark Templar)
            }
            else{
                actType = @"null";
                actUnit = @"null";
            }
        }
        else{
            //可能是build 或者是 Spawn Larva（注卵）或者是 Chrono Boost（p星空加速）
            //或者是人族矿骡
            //这些直接加到列表中去
            
            NSString *targets = [actionArr objectAtIndex:1];
            
            if ([act hasPrefix:@"Chrono"]){
                // 363|Chrono Boost (Nexus); target: Nexus (10254)
                actType = @"Marco";
                actUnit = @"Chrono Boost";
                targets = [targets substringFromIndex:8];
                NSArray *ts = [targets componentsSeparatedByString:@"("];
                actTarget = [[ts objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            else if ([act hasPrefix:@"Spawn Larva"]){
                actType = @"Marco";
                actUnit = @"Spawn Larva";
            }
            else if ([act hasPrefix:@"Spawn Creep Tumor"]){
                actType = @"Marco";
                actUnit = @"Spawn Creep Tumor";
            }
            else if ([act hasPrefix:@"Calldown MULE"]){
                actType  =@"Marco";
                actUnit = @"Calldown MULE";
            }
            else if ([act hasPrefix:@"Build"]){
                actType  =@"Build";
                actUnit = [act substringFromIndex:5];
                actUnit = [actUnit stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSArray *ts = [actUnit componentsSeparatedByString:@"("];
                if ([ts count]>1) {
                    NSString *tar = [[ts objectAtIndex:1]stringByReplacingOccurrencesOfString:@")" withString:@""];
                    actTarget = tar;
                    if([actUnit hasPrefix:@"Reactor"]) {
                        actUnit = @"Reactor";
                    }else if([actUnit hasPrefix:@"Tech Lab"]){
                        actUnit = @"Tech Lab";
                    }else{
                        
                    }
                }
                
            }
            //神族传兵
            else if([act hasPrefix:@"Train"]){
                actType = @"TrainWarpGate";
                actUnit = [act substringFromIndex:5];
                actUnit = [actUnit stringByReplacingOccurrencesOfString:@"(Warp gate)" withString:@""];
            }
            else {
                actType = @"null";
                actUnit = @"null";
            }
        }
        actUnit = [actUnit stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.nodeType = actType;
        self.nodeUnit = actUnit;
        self.actionTarget = actTarget;
    }
    
    return self;
    
}

@end
