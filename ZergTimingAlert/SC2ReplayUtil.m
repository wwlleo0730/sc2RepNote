//
//  SC2ReplayUtil.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-30.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "SC2ReplayUtil.h"
#import "SC2Timing.h"
#import "SC2ReplayNode.h"
#import "DDFileReader.h"
#import "SC2Replay.h"

@implementation SC2ReplayUtil

@synthesize allReplays = _allReplays;
@synthesize allPlayers = _allPlayers;

@synthesize zergTrainArray = _zergTrainArray;


@synthesize buildingOrder = _buildingOrder;
@synthesize replayInfo = _replayInfo;

@synthesize buildingArray = _buildingArray;
@synthesize unitArray = _unitArray;
@synthesize imptantArray = _imptantArray;
@synthesize zergbuildingArray = _zergbuildingArray;

@synthesize rightShowArray = _rightShowArray;

@synthesize timingArray = _timingArray;

@synthesize repActionsArray = _repActionsArray;

@synthesize buildShowArray = _buildShowArray;
@synthesize unitShowArray = _unitShowArray;


+(SC2ReplayUtil *)getSc2ReplayUtil{
    static SC2ReplayUtil *util;
    @synchronized(self){
        if(!util){
            util = [[SC2ReplayUtil alloc]init];
        }
        return util;
    }
}

-(NSString *)getRaceByPlayerName:(NSString *)name{
    NSArray *zergs = [_allPlayers objectForKey:@"zerg"];
    NSArray *protoss = [_allPlayers objectForKey:@"protoss"];
    NSArray *terrans = [_allPlayers objectForKey:@"terran"];
    if ([zergs containsObject:name]) {
        return @"zerg";
    }
    else if ([protoss containsObject:name]) {
        return @"protoss";
    }
    else if ([terrans containsObject:name]) {
        return @"terran";
    }
    else return @"";
}



-(void)getReplayJson{

    
}


/*
 是否为建筑
 */
-(BOOL)isBuilding:(NSString *) unit{
    return [_buildingArray containsObject:unit];
}


/*是否虫族单位*/
-(BOOL)isZergBuilding:(NSString *) unit{
    return [_zergbuildingArray containsObject:unit];
}

/*
 是否为单位，特例虫族overlord算单位而不是建筑
 */
-(BOOL)isUnit:(NSString *)unit{
    return [_unitArray containsObject:unit];
}

-(BOOL)isShowRight:(NSString *)unit{
    return [_rightShowArray containsObject:unit];
}

//是否记录在build列表中
-(BOOL)isBuildCount:(NSString *)unitTag{
    return [_buildShowArray containsObject:unitTag];
} 

//是否记录在数量列表中
-(BOOL)isUnitCount:(NSString *)unitTag{
    return [_unitShowArray containsObject:unitTag];
}


/*
 是否重要建筑 需要特别提醒
 */
 
-(BOOL)isImportant:(NSString *) unit{
    //根据名称判断是否关键建筑
    return [_imptantArray containsObject:unit];
}


//是否记录在列表中
-(BOOL)isRecordInArr:(NSString *)actType{
//    return TRUE;
   return ([actType isEqualToString:@"Build"]||[actType isEqualToString:@"Research"]
              ||[actType isEqualToString:@"Upgrade"]||[actType isEqualToString:@"Marco"]);
}

-(NSMutableDictionary *)formatListDataByFilePath:(NSString *)fileName{
    NSMutableDictionary *actionDic = [[NSMutableDictionary alloc]init];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:filePath];
    NSString __block *time = @"";
    [reader enumerateLinesUsingBlock:^(NSString * line, BOOL * stop) {
        SC2ReplayNode *node = [[SC2ReplayNode alloc]initWithFileLine:line];
        time = node.happenTime;
        if ([actionDic objectForKey:time]) {
            NSMutableArray *d = [actionDic objectForKey:time];
            [d addObject:node];
        }
        else{
            NSMutableArray *d = [[NSMutableArray alloc]init];
            [d addObject:node];
            [actionDic setObject:d forKey:time];
        }        
    }];
    [actionDic setObject:time forKey:@"endtime"];
    return actionDic;
  }


-(NSMutableDictionary *)formatListData:(NSArray *)jsonData{
    NSMutableDictionary *actionDic = [[NSMutableDictionary alloc]init];
    for (int i=0; i< [jsonData count]; i++){
        NSDictionary *obj = [jsonData objectAtIndex:i];
        NSString *time = [obj objectForKey:@"t"];
        NSString *act = [obj objectForKey:@"a"];
        NSString *actUnit = @"";
        NSString *actType = @"";
        if ([act hasPrefix:@"Train"]) {
            actType = @"Train";
            actUnit = [act substringFromIndex:5];
        }else if([act hasPrefix:@"Build"]){
            actType = @"Build";
            actUnit = [act substringFromIndex:5];
        }else {
            actType = @"Update";
            actUnit = [act substringFromIndex:6];
        }
        
        actUnit = [actUnit stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
       SC2ReplayNode *node = [[SC2ReplayNode alloc]init];
       [node setNodeType:actType];
       [node setHappenTime:time];
       [node setNodeUnit:actUnit];

        if ([actionDic objectForKey:time]) {
            NSMutableArray *d = [actionDic objectForKey:time];
            [d addObject:node];
        }
        else{
             NSMutableArray *d = [[NSMutableArray alloc]init];
            [d addObject:node];
            [actionDic setObject:d forKey:time];
        }
    }
    return actionDic;
}


-(id)init{
    self = [super init];
    if (self) {
        _allReplays =  [[NSMutableArray alloc]init];
        NSString *replaysPath=[[NSBundle mainBundle] pathForResource:@"replaysList" ofType:@"plist"];
        NSMutableDictionary *myDic = [[NSMutableDictionary alloc]initWithContentsOfFile:replaysPath];
        for (NSString *key in [myDic allKeys]) {
            NSArray *reps = [myDic objectForKey:key];
            for (NSDictionary *obj in reps) {
                SC2Replay *rep = [[SC2Replay alloc]init];
                rep.mapName = [obj objectForKey:@"mapName"];
                rep.fightType = [obj objectForKey:@"fightType"];
                rep.repPlayer = [obj objectForKey:@"player"];
                rep.repInfo = [obj objectForKey:@"repInfo"];
                rep.repStrategy = [obj objectForKey:@"repStrategy"];
                rep.repName = [obj objectForKey:@"repName"];
                rep.showRace = [obj objectForKey:@"showRace"];
                [_allReplays addObject:rep];
            }
        }
        
        NSString *playersPath=[[NSBundle mainBundle] pathForResource:@"players" ofType:@"plist"];
        _allPlayers = [[NSMutableDictionary alloc]initWithContentsOfFile:playersPath];
        
        _unitArray = [[NSMutableArray alloc]initWithObjects:
                                    @"Drone",@"Overlord",@"Zergling",@"Queen",@"Hydralisk",@"Baneling",@"Overseer",@"Roach",@"Infestor",@"Mutalisk",@"Corruptor",@"Ultralisk",@"Brood Lord"
                                    @"Scv",@"Marine",@"Marauder",@"Reaper", 
                                    @"Probe",@"Zealot",
                                    nil];
        
        _zergTrainArray = [[NSMutableArray alloc]initWithObjects:
                           @"Drone",@"Zergling",@"Roach",@"Queen",@"Overlord",
                           nil];
        
        _zergbuildingArray = [[NSMutableArray alloc]initWithObjects:
                              @"Spawning Pool",@"Hatchery",@"Extractor",@"Evolution Chamber",@"Lair",@"Hive",
                              nil];
        
        _buildingArray = [[NSMutableArray alloc]initWithObjects:
                          @"Spawning Pool",@"Hatchery",@"Extractor",@"Evolution Chamber",@"Lair",@"Hive",
                          
                          @"Commandcenter",@"supplydepot",@"refinery",@"barracks" 
                          @"Nexus",@"pylon",@"assimilator",@"gateway",
                          nil];
        
        
        
        
        _imptantArray = [[NSMutableArray alloc]initWithObjects:
                         @"overlord",@"pylon",@"supplydepot",@"queen",
                         nil];
        
        _rightShowArray = [[NSMutableArray alloc]initWithObjects:
                            @"drone",@"zergling",@"roach",@"queen", nil];
        
        _repActionsArray = [[NSMutableArray alloc]initWithObjects:
                            @"Upgrade",@"Build",@"Train",@"queen", nil];
        
        _buildShowArray = [[NSMutableArray alloc]initWithObjects:
                           @"Hatchery",@"Spine Crawler",@"Spore Crawler",@"Overload", 
                           @"Orbital Command",@"Planetary Fortress",@"Barracks",@"Factory",@"Starport",
                           @"Gateway",@"Stargate",@"Warp Gate",@"Nexus",
                           nil];
        
        _unitShowArray = [[NSMutableArray alloc]initWithObjects:
                          @"Drone",@"Zergling",@"Roach",@"Baneling",@"Mutalisk" 
                          @"SCV",@"Marine",@"Marauder",@"Hellion",@"Siege Tank",
                          @"Probe",@"Zealot",@"Stalker",@"Sentry",@"Immortal",
                          nil];
        
        
        

//        SC2Timing *pvz1 = [[SC2Timing alloc]initWithInfo:@"pvz" desc:@"单机场虚空一波rush" descpic:@"icon-terran.png" timingName:@"虚空一波" time:300];
//        SC2Timing *pvz2 = [[SC2Timing alloc]initWithInfo:@"pvz" desc:@"4BG rush" descpic:@"icon-zerg.png" timingName:@"4bgrush" time:500];
//        
//        _timingArray = [[NSMutableArray alloc]initWithObjects:pvz1,pvz2, nil];
//        
//        
//        
        
    }
    return self;
}



@end
