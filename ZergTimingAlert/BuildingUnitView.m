//
//  BuildingUnitView.m
//  ZergTimingAlert
//
//  Created by wwl on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "BuildingUnitView.h"
#import "Globals.h"
#import "GroupProgressShow.h"
#import "ProgressShow.h"
#import "UnitShow.h"
#import "SC2ReplayUtil.h"
#import "StarcraftBaseUnit.h"
#import <QuartzCore/QuartzCore.h>
#import "SC2ReplayNode.h"
#import "StarcraftBaseUnit.h"
#import "ReplaysRunTime.h"
#import "WarpGateProgressShow.h"

@implementation BuildingUnitView

@synthesize buildingDict = _buildingDict;
@synthesize buildingUnitGroupArray = _buildingUnitGroupArray;
@synthesize buildedDict = _buildedDict;

@synthesize buildedUnitDict = _buildedUnitDict;

@synthesize supplys = _supplys;
@synthesize units = _units;
@synthesize farmunits = _farmunits;
@synthesize combatunits = _combatunits;



@synthesize unitsLabel = _unitsLabel;
@synthesize supplyLabel = _supplyLabel;
@synthesize timeLabel = _timeLabel;
@synthesize timePassed = _timePassed;

@synthesize buildlistTable = _buildlistTable;
@synthesize buildOrderArr = _buildOrderArr;

@synthesize leftShowView = _leftShowView;
@synthesize UnderShowView = _UnderShowView;

@synthesize showRace = _showRace;



//视图从nib文件初始化
- (id)initWithCoder:(NSCoder *)aDecoder{
	if ((self = [super initWithCoder:aDecoder])) {        
        _buildingDict = [[NSMutableDictionary alloc]init];
        _buildingUnitGroupArray = [[NSMutableArray alloc] init];
        _buildedDict =  [[NSMutableDictionary alloc]init];
        _buildedUnitDict = [[NSMutableDictionary alloc]init];

        _buildlistTable = [[UITableView alloc]initWithFrame:CGRectMake(115, 50, 200, 255) style:UITableViewStylePlain];
        _buildlistTable.delegate = self;
        _buildlistTable.dataSource = self;
        _buildlistTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _buildlistTable.separatorColor = HEXCOLOR(0x1BA1E2);
        [_buildlistTable setBackgroundColor:HEXCOLOR(0x1BA1E2)];
        [self addSubview:_buildlistTable];
        
        _buildOrderArr = [[NSMutableArray alloc]init];
       _leftShowView = [[UIScrollView alloc]initWithFrame:CGRectMake(5,50,105,255)];
        _leftShowView.backgroundColor = HEXCOLOR(unitshowbgcolor);
        [self addSubview:_leftShowView];
	}
	return self;
}


-(void)setShowRace:(NSString *)showRace{
    _showRace = showRace;
    _supplys = 10;
    _units = 6;
    if ([_showRace isEqualToString:@"terran"]) {
        _supplys = 11;
    }
    _supplyLabel.text = [NSString stringWithFormat:@"%d",_supplys];
    _unitsLabel.text = [NSString stringWithFormat:@"%d",_units];
    NSString *tag = @"";
    NSString *baseTag = @"";
    if ([_showRace isEqualToString:@"zerg"]) {
        tag = @"Drone";
        baseTag = @"Hatchery";
    }else if([_showRace isEqualToString:@"protoss"]){
        tag = @"Probe";
        baseTag = @"Nexus";
    }else {
        tag = @"SCV";
        baseTag = @"Command Center";
    }
    
    //农民
    UnitShow *unitshow = [[UnitShow alloc]initWithTag:tag frame:CGRectMake(alertViewMargin,alertViewHeight,kLauncherBtnSize,kLauncherBtnSize)];
    [unitshow setUnitNum:6];
    [_leftShowView addSubview:unitshow];
    [_buildedUnitDict setObject:unitshow forKey:tag];
    
    if ([_showRace isEqualToString:@"zerg"]) {
        UnitShow *unitshow = [[UnitShow alloc]initWithTag:@"Overlord" frame:CGRectMake(alertViewMargin,alertViewHeight+unitSpace,kLauncherBtnSize,kLauncherBtnSize)];
        [unitshow setUnitNum:1];
        [_leftShowView addSubview:unitshow];
        [_buildedUnitDict setObject:unitshow forKey:@"Overlord"];
    }
    
    //基地
    UnitShow *unitBaseshow = [[UnitShow alloc]initWithTag:baseTag frame:CGRectMake(alertViewMargin+unitSpace,alertViewHeight,kLauncherBtnSize,kLauncherBtnSize)];
    [unitBaseshow setUnitNum:1];
    
    [_leftShowView addSubview:unitBaseshow];
    [_buildedDict setObject:unitBaseshow forKey:baseTag];
    
    
    
}

-(void)setTimePassed:(int)timePassed{
    int min = timePassed/60;
    int sec = timePassed%60;
    _timePassed = timePassed;
    _timeLabel.text = [NSString stringWithFormat: @"%d : %d",min,sec];
}

- (void)shakeView:(UIView *)viewToShake{
    CGAffineTransform newTransform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:2.5
            delay:0.0 
            options:UIViewAnimationOptionCurveEaseOut
            animations:^{
                [viewToShake setFrame:CGRectMake(90, 100, 140, 140)];
                viewToShake.alpha = 1;
            }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
//                             viewToShake.transform = newTransform;
                             [UIView animateWithDuration:0.35
                                          delay:0.0 
                                          options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat 
                                          animations:^{
                                              [UIView setAnimationRepeatCount:8];
                                              viewToShake.transform = newTransform;
                                  }
                                              completion:^(BOOL finished){
                                                  if (finished) {
                                                      
                                                      [UIView animateWithDuration:2
                                                                            delay:0.0 
                                                                          options:0 
                                                                       animations:^{
                                                                           viewToShake.alpha = 0;
                                                                           [viewToShake setFrame:CGRectMake(110, 50, 0, 0)];
                                                                       }
                                                      
                                                                       completion:^(BOOL finished){
                                                                            [viewToShake removeFromSuperview];
                                                                       }];
                                                      
                                                      
                                                      
                                                     
                                                  }
                                              }];
                             
                         }
                         
                     }];
}


-(void)showMVPAni:(NSString *)unitTag{
    StarcraftBaseUnit *util = [StarcraftBaseUnit getSc2Base];
    UIImage *image = [util UnitImageBytag:unitTag];
    UIImageView *firstImageView = [[UIImageView alloc] initWithImage:image];
    [firstImageView setFrame:CGRectMake(90, 130, 140, 140)];
    firstImageView.alpha = 0.5;
    [self addSubview:firstImageView];
    [self shakeView:firstImageView];
}



//增加units数量 zerg一开始建造即增加人数 T和P建造完成才增加人数
-(void)plusUnits:(int)num{
    _units += num;
}

//特例 zerg建造建造需要减少1人口
-(void)minsUnits:(int)num{
    _units -= num;
}


-(void)addSingleUnitByNode:(SC2ReplayNode *)sc2RepNode{
    NSString *unitTag = sc2RepNode.nodeUnit;
    if ([_buildingDict objectForKey:unitTag]) {
        //如果存在
        GroupProgressShow *thisTagGroup = [_buildingDict objectForKey:unitTag];
        [thisTagGroup addNewUnitInGroupByNode];
    }
    else{
        //创建新的group 加入
        int n = [_buildingUnitGroupArray count];
        GroupProgressShow *newGroup = [[GroupProgressShow alloc]initWithUnitTagByNode:sc2RepNode frame:CGRectMake(0, 0, 0, 0)];
        newGroup.delegate = self;
        newGroup.frame = CGRectMake(alertViewMargin+(n%kNumOfLine)*unitSpace, buildingViewHeight+(n/kNumOfLine)*unitSpace, kLauncherBtnSize, kLauncherBtnSize);
        [newGroup addNewUnitInGroupByNode];
        [self addSubview:newGroup];
        [_buildingDict setObject:newGroup forKey:unitTag];
        [_buildingUnitGroupArray addObject:newGroup];
    }
}

-(void)chronoEffectForWarpGate:(SC2ReplayNode *)node{
    if(![node.nodeUnit isEqualToString:@"Chrono Boost"]){
    }else{
        if ([node.actionTarget isEqualToString:@"Cybernetics Core"]) {
            //存在开门加速
            if ([_buildingDict objectForKey:@"Protoss Warp Gate"]) {
                GroupProgressShow *group = [_buildingDict objectForKey:@"Protoss Warp Gate"];
                WarpGateProgressShow *p = [group.unitArray objectAtIndex:0];
                [p chronoEffected];
            }
        }
    }
}


-(void)isAddToBuilderOrderArr:(SC2ReplayNode *)node{
    SC2ReplayUtil *u = [SC2ReplayUtil getSc2ReplayUtil];
    if ([u isRecordInArr:node.nodeType]){
        [_buildOrderArr addObject:node];
        [_buildlistTable reloadData];
    }
    [self chronoEffectForWarpGate:node];
}


//该类被调用的入口函数
-(void)addUnitInFlow:(NSObject *)unit{
    if ([unit isKindOfClass:[NSString class]]) {
        SC2ReplayNode *node = (SC2ReplayNode *)unit;
        [self addSingleUnitByNode:node];
        [self isAddToBuilderOrderArr:node];
    }
    else{
        NSArray *as = (NSArray *)unit;
        for (SC2ReplayNode *node in as) {
            [self addSingleUnitByNode:node];
            [self isAddToBuilderOrderArr:node];
        }
    }
}


//开始运行
-(void)unitShowStart:(NSString *)unitTag{
    if ([[StarcraftBaseUnit getSc2Base]isZergBuilding:unitTag]) {
        [self minsUnits:1];
        //在已完成列表栏中减少1农民数量
        UnitShow *droneUnit = [_buildedUnitDict objectForKey:@"Drone"];
        [droneUnit minusNum];
    }
    //不是zerg建筑
    //可能是PT的建筑或者unit，或者z的unit
    else{
        //如果是p t的建筑，那么不加人口
        if ([[StarcraftBaseUnit getSc2Base]isBuilding:unitTag]){
            
        }
        //否则是unit
        else{
            int unitCost =  [[StarcraftBaseUnit getSc2Base]UnitCost:unitTag];
            [self plusUnits:unitCost];
        }
        if ([_showRace isEqualToString:@"zerg"]) {
            //如果是毒爆
            if ([unitTag isEqualToString:@"Baneling"]) {
                UnitShow *droneUnit = [_buildedUnitDict objectForKey:@"Zergling"];
                [droneUnit minusNum];
            }                
            //            }else if([unitTag isEqualToString:@""]){
            //                
            //            }            
            //如果是大龙
        }else if ([_showRace isEqualToString:@"Terran"]){
            
        }else{
            //和白球
        }
    }
    _supplyLabel.text = [NSString stringWithFormat:@"%d",_supplys];
    _unitsLabel.text = [NSString stringWithFormat:@"%d",_units];
    
}


//添加
-(void)addUnitBuilded:(NSString *)unitTag{
    //supply增加
   _supplys += [[StarcraftBaseUnit getSc2Base]supplyAddAfterBuild:unitTag];
   _supplyLabel.text = [NSString stringWithFormat:@"%d",_supplys];
//   _unitsLabel.text = [NSString stringWithFormat:@"%d",_units];
//    _supplyLabel.text = [NSString stringWithFormat:@"%d / %d",_units,_supplys];
    //unit增加的数量和人口增加的数量不同
    int unitnumAdd = [[StarcraftBaseUnit getSc2Base]UnitAddAfterProduce:unitTag];
    //如果是建筑
    //如果为建筑 放在右边一列
    if ([[StarcraftBaseUnit getSc2Base]isBuilding:unitTag]) {
        int n = [[_buildedDict allKeys]count];
        //有已经建造的
        if ([_buildedDict objectForKey:unitTag]) {
            UnitShow *thisUnit = [_buildedDict objectForKey:unitTag];
            [thisUnit setUnitNum:(thisUnit.unitNum+unitnumAdd)];
        }else{
            UnitShow *unitshow = [[UnitShow alloc]initWithTag:unitTag frame:CGRectMake(alertViewMargin+unitSpace,alertViewHeight+n*unitSpace,kLauncherBtnSize,kLauncherBtnSize)];
            [unitshow setUnitNum:unitnumAdd];
            [_leftShowView addSubview:unitshow];
            [_buildedDict setObject:unitshow forKey:unitTag];
        }
        ReplaysRunTime *runTime = [ReplaysRunTime getRepRunTime];
        [runTime plusBaseNum:unitTag];
    //否则是单位
    //如果为单位 放在左边一列
    }else if([[StarcraftBaseUnit getSc2Base]isUnit:unitTag]){
        int n = [[_buildedUnitDict allKeys]count];
        if ([_buildedUnitDict objectForKey:unitTag]) {
            UnitShow *thisUnit = [_buildedUnitDict objectForKey:unitTag];
            [thisUnit setUnitNum:(thisUnit.unitNum+unitnumAdd)];
        }else{
            UnitShow *unitshow = [[UnitShow alloc]initWithTag:unitTag frame:CGRectMake(alertViewMargin,alertViewHeight+n*unitSpace,kLauncherBtnSize,kLauncherBtnSize)];
            [unitshow setUnitNum:unitnumAdd];
            [_leftShowView addSubview:unitshow];
            [_buildedUnitDict setObject:unitshow forKey:unitTag];
        }
    }else{
        //即不是建造也不是兵
        //是marco操作或者research或者upgrade
    }
    
    int k = [_buildedUnitDict count] > [_buildedDict count]?[_buildedUnitDict count]:[_buildedDict count];
    
    if (k>5) {
         [_leftShowView setContentSize:CGSizeMake(105, k*50+5)];
    }

}



//全部view完成
-(void)groupShowEnded:(GroupProgressShow *) group{
    
    if ([group.unitArray count]<=0) {
        [group removeFromSuperview];
        [_buildingUnitGroupArray removeObject:group];
        [_buildingDict removeObjectForKey:group.unitTag];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:0
                         animations:^{
                             for (int k=0; k< [_buildingUnitGroupArray count];k++) {
                                 GroupProgressShow *groups = [_buildingUnitGroupArray objectAtIndex:k];
                                 groups.frame = CGRectMake(alertViewMargin+(k%kNumOfLine)*unitSpace, buildingViewHeight+(k/kNumOfLine)*unitSpace, kLauncherBtnSize, kLauncherBtnSize);
                             }
                         }
                         completion:^(BOOL finished){
                             if (finished){
                                 
                             }
                         }
         ];

    }
    
}


//section num
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_buildOrderArr count];
}

//定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SC2ReplayNode *node = [_buildOrderArr objectAtIndex:[_buildOrderArr count]-indexPath.row-1];
    StarcraftBaseUnit *util = [StarcraftBaseUnit getSc2Base];
    UIImage *image = [util UnitImageBytag:node.nodeUnit];
    cell.imageView.image = image;
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor darkTextColor];
    
//    _tabBarController.btnName = [[NSArray alloc]initWithObjects:NSLocalizedString(@"tabName1",nil),NSLocalizedString(@"tabName2",nil),NSLocalizedString(@"tabName3",nil), nil];
    NSString *showName = NSLocalizedString(node.nodeUnit,nil);
    int t = [node.happenTime intValue];
    int sec = t % 60;
    int min = t / 60;
    cell.textLabel.numberOfLines = 0;
    if (![node.actionTarget isEqualToString:@""]) {
        showName = [showName stringByAppendingFormat:@" %@",NSLocalizedString(node.actionTarget,nil)];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",showName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d:%d",min,sec];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)cleanSelf{
    for (GroupProgressShow *groups in _buildingUnitGroupArray) {
        for (ProgressShow *show in groups.unitArray) {
            [show removeFromSuperview];
        }
    }
    [_buildingUnitGroupArray removeAllObjects];
    _buildingUnitGroupArray = nil;
    [_buildingDict removeAllObjects];
    _buildingDict =nil;
    [_buildedDict removeAllObjects];
    _buildedDict =  nil;
    [_buildedUnitDict removeAllObjects];
    _buildedUnitDict = nil;
    [_buildlistTable removeFromSuperview];
}



@end
