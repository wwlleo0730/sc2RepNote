//
//  StarcraftBaseUnit.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SC2ReplayNode.h"

@interface StarcraftBaseUnit : NSObject

@property (nonatomic,strong) NSMutableDictionary *unitInfo; //兵种信息
@property (nonatomic,strong) NSMutableDictionary *replay1; // ZVP 3开

@property (nonatomic,strong) NSMutableArray *zergBuildingArray;

@property (nonatomic,strong) NSMutableArray *buildingArray;
@property (nonatomic,strong) NSMutableArray *unitArray;


-(UIImage *)UnitImageBytag:(NSString *)tag;

-(int)UnitDuringByTag:(NSString *)tag; //建造或者升级花费时间
-(int)UnitDuringByNode:(SC2ReplayNode *)node; //建造或者升级花费时间

-(int)UnitCost:(NSString *)tag;
-(int)UnitCost:(NSString *)tag; //耗费人口
-(int)UnitAddAfterProduce:(NSString *)tag;//增加数量
-(int)supplyAddAfterBuild:(NSString *)tag;//supply增加数量

+(StarcraftBaseUnit *)getSc2Base;



-(BOOL)isZergBuilding:(NSString *) unit;
-(BOOL)isBuilding:(NSString *) unit;
-(BOOL)isUnit:(NSString *) unit;
@end
