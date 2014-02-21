//
//  BuildingUnitView.h
//  ZergTimingAlert
//  用于显示建造中的物体
//  合并相同的建造物体
//  Created by wwl on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupProgressShow.h"
#import "StarcraftBaseUnit.h"

@interface BuildingUnitView : UIView<GroupProgressShowDelegate,UITableViewDelegate,UITableViewDataSource>{

}

@property (nonatomic,strong) NSMutableArray *buildingUnitGroupArray;//当前建造中的
@property (nonatomic,strong) NSMutableDictionary *buildingDict; //包括建筑和兵

@property (nonatomic,strong) NSMutableDictionary *buildedDict; //建造完毕的建筑
@property (nonatomic,strong) NSMutableDictionary *buildedUnitDict; //建造完毕的兵



//@property (nonatomic,strong) UIView *buildedUnitView; //完成区域

@property (nonatomic,assign) int farmunits; //农民
@property (nonatomic,assign) int combatunits; //战斗单位
@property (nonatomic,assign) int units; // farmunits+combatunits
@property (nonatomic,assign) int supplys; //补给


@property (nonatomic,strong) NSString *showRace;//显示种族 zerg protoss terran


@property (nonatomic,strong) IBOutlet UILabel *unitsLabel;
@property (nonatomic,strong) IBOutlet UILabel *supplyLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;


@property (nonatomic,strong) UIScrollView *leftShowView;
@property (nonatomic,strong) UIScrollView *UnderShowView;


@property (nonatomic,strong) UITableView *buildlistTable;
@property (nonatomic,strong) NSMutableArray *buildOrderArr;

@property (nonatomic,assign) int timePassed;



-(void)addUnitInFlow:(NSObject *)unitTag; //加入队列


-(void)plusUnits:(int)num; //增加units数量 zerg一开始建造即增加人数 T和P建造完成才增加人数
-(void)minsUnits:(int)num;//特例 zerg建造建造需要减少1人口



-(void)cleanSelf;







@end
