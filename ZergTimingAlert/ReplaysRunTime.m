//
//  ReplaysRunTime.m
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-3.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "ReplaysRunTime.h"

@implementation ReplaysRunTime

@synthesize baseNum = _baseNum;
@synthesize barracksNum = _barracksNum;
@synthesize factoryNum = _factoryNum;


+(ReplaysRunTime *)getRepRunTime{
    static ReplaysRunTime *runTime;
    @synchronized(self){
        if(!runTime){
            runTime = [[ReplaysRunTime alloc]init];
        }
        return runTime;
    }
}


-(void)initRepNum{
    _baseNum = 1; //初始肯定有一个基地
    //以下暂时不考虑
    _barracksNum = 0;
    _factoryNum = 0;
}

-(id)init{
    self = [super init];
    if (self) {
        [self initRepNum];
    }
    return self;
}

-(void)plusBaseNum:(NSString *)tag{
    if ([tag isEqualToString:@"Command Center"]) {
        _baseNum = _baseNum+1;
    }
}

////占据资源
////如果当前没有基地资源，则返回
-(Boolean)Pfuntion:(NSString *)tag{
    if ([tag isEqualToString:@"SCV"]) {
        if (_baseNum > 0) {
            _baseNum = _baseNum-1;
            return true;
        }
        return false;
    }
    else return true;
}

////农民占据资源
////如果当前没有基地资源，则返回
//-(Boolean)Pfuntion{
//    if (_baseNum >= 0) {
//        _baseNum = _baseNum-1;
//        return true;
//    }
//     
//    else return false;
//}
//释放资源
-(Boolean)Vfuntion:(NSString *)tag{
    if ([tag isEqualToString:@"SCV"]) {
         _baseNum = _baseNum+1;
        return true;
    }
    else return false;
}



@end
