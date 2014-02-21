//
//  SC2ReplayUtil.h
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-30.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC2ReplayUtil : NSObject


@property (nonatomic,strong) NSMutableArray *allReplays;
@property (nonatomic,strong) NSDictionary *allPlayers;

@property (nonatomic,strong) NSMutableArray *zergTrainArray;


@property (nonatomic,strong) NSString *replayInfo;

@property (nonatomic,strong) NSMutableDictionary *buildingOrder;
@property (nonatomic,strong) NSMutableArray *buildingArray;
@property (nonatomic,strong) NSMutableArray *zergbuildingArray;
@property (nonatomic,strong) NSMutableArray *unitArray;


@property (nonatomic,strong) NSMutableArray *imptantArray;

@property (nonatomic,strong) NSMutableArray *buildShowArray;
@property (nonatomic,strong) NSMutableArray *unitShowArray;

@property (nonatomic,strong) NSMutableArray *repActionsArray;
@property (nonatomic,strong) NSMutableArray *rightShowArray;
@property (nonatomic,strong) NSMutableArray *timingArray;

//@property (nonatomic,strong) NSMutableDictionary *unitNum;
+(SC2ReplayUtil *)getSc2ReplayUtil;


-(NSString *)getRaceByPlayerName:(NSString *)name;

-(NSMutableDictionary *)formatListData:(NSArray *)jsonData;
-(NSMutableDictionary *)formatListDataByFilePath:(NSString *)fileName;

-(BOOL)isRecordInArr:(NSString *)actType;
-(BOOL)isImportant:(NSString *) unit;
-(BOOL)isShowRight:(NSString *)unit;
-(BOOL)isBuildCount:(NSString *)unitTag; //是否记录在build列表中
-(BOOL)isUnitCount:(NSString *)unitTag; //是否记录在数量列表中

-(BOOL)isBuilding:(NSString *) unit;

/*是否虫族单位*/
-(BOOL)isZergBuilding:(NSString *) unit;
/*
 是否为单位，特例虫族overlord算单位而不是建筑
 */
-(BOOL)isUnit:(NSString *)unit;
@end
