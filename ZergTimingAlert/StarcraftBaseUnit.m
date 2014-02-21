//
//  StarcraftBaseUnit.m
//  ZergTimingAlert
//
//  Created by 文立 吴 on 12-3-29.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "StarcraftBaseUnit.h"

@implementation StarcraftBaseUnit

@synthesize unitInfo = _unitInfo;
@synthesize replay1 = _replay1;

@synthesize zergBuildingArray = _zergBuildingArray;
@synthesize buildingArray = _buildingArray;
@synthesize unitArray = _unitArray;


+(StarcraftBaseUnit *)getSc2Base{
    static StarcraftBaseUnit *util;	
    @synchronized(self){
        if(!util){
            util = [[StarcraftBaseUnit alloc]init];
        }
        return util;
    }
}


/*是否虫族建筑*/
-(BOOL)isZergBuilding:(NSString *) unit{
    return [_zergBuildingArray containsObject:unit];
}
/*是否建筑*/
-(BOOL)isBuilding:(NSString *) unit{
    return [_buildingArray containsObject:unit];
}

/*是否单位*/
-(BOOL)isUnit:(NSString *) unit{
    return [_unitArray containsObject:unit];
}



-(id)init{
    self = [super init];
    if (self) {
        
        
        _zergBuildingArray = [[NSMutableArray alloc]initWithObjects:
                          @"Spawning Pool",@"Hatchery",@"Extractor",@"Evolution Chamber",@"Spine Crawler",@"Spore Crawler",@"Roach Warren",@"Baneling Nest",@"Hydralisk Den",@"Infestation Pit",@"Spire",@"Nydus Network",@"Ultralisk Cavern",
                          nil];
        _buildingArray  = [[NSMutableArray alloc]initWithObjects:
                          @"Spawning Pool",@"Hatchery",@"Extractor",@"Evolution Chamber",@"Spine Crawler",@"Spore Crawler",@"Roach Warren",@"Baneling Nest",@"Hydralisk Den",@"Infestation Pit",@"Spire",@"Nydus Network",@"Ultralisk Cavern",
                            @"Command Center",@"Orbital Command",@"Planetary Fortress",@"Supply Depot",@"Refinery",@"Barracks",@"Engineering Bay",@"Bunker",@"Missile Turret",@"Sensor Tower",@"Factory",
                            @"Ghost Academy",@"Armory",@"Starport",@"Fusion Core",@"Tech Lab",@"Reactor",
                           
                            @"Nexus",@"Pylon",@"Assimilator",@"Gateway",@"Forge",@"Cybernetics Core",@"Dark Shrine",@"Photon Cannon",@"Fleet Beacon",@"Stargate",@"Twilight Council",@"Robotics Facility",@"Templar Archives",@"Robotics Bay",
                          nil];
        _unitArray = [[NSMutableArray alloc]initWithObjects:
                      @"Drone",@"Overlord",@"Overseer",@"Zergling",@"Queen",@"Roach",@"Hydralisk",@"Baneling",@"Infestor",@"Mutalisk",@"Corruptor",@"Ultralisk",@"Brood Lord",
                      @"SCV",@"Marine",@"Marauder",@"Reaper",@"Ghost",@"Hellion",@"Siege Tank",@"Thor",@"Viking",@"Medivac",@"Raven",@"Banshee",@"Battlecruiser",
                      @"Probe",@"Zealot",@"Stalker",@"Sentry",@"Observer",@"Immortal",
                      @"Warp Prism",@"Colossus",@"Phoenix",@"Void Ray",@"High Templar",
                      @"Dark Templar",@"Archon",@"Carrier",@"Mothership",
                      nil];
        
        
        _unitInfo = [[NSMutableDictionary alloc]init];
        
        
        NSMutableDictionary *unitImg = [[NSMutableDictionary alloc]init];
        
        [unitImg setValue:@"drone.png" forKey:@"Drone"]; //农民
        [unitImg setValue:@"overlord.png" forKey:@"Overlord"]; //overload
        [unitImg setValue:@"overseer.png" forKey:@"Overseer"];//眼虫
        [unitImg setValue:@"zergling.png" forKey:@"Zergling"]; //狗
        [unitImg setValue:@"queen.png" forKey:@"Queen"]; //女王
        [unitImg setValue:@"roach1.png" forKey:@"Roach"]; //蟑螂
        [unitImg setValue:@"hydralisk.png" forKey:@"Hydralisk"];//刺蛇
        [unitImg setValue:@"baneling.png" forKey:@"Baneling"];//毒爆
        [unitImg setValue:@"infestor.png" forKey:@"Infestor"];//感染虫
        [unitImg setValue:@"mutalisk.png" forKey:@"Mutalisk"];//飞龙
        [unitImg setValue:@"corruptor.png" forKey:@"Corruptor"];//腐化
        [unitImg setValue:@"ultralisk.png" forKey:@"Ultralisk"];//大牛
        [unitImg setValue:@"broodlord.png" forKey:@"Brood Lord"];//大龙
        
        [unitImg setValue:@"hatchery.png" forKey:@"Hatchery"];//基地
        [unitImg setValue:@"extractor.png" forKey:@"Extractor"];//气矿
        [unitImg setValue:@"spawningpool.png" forKey:@"Spawning Pool"];//血池
        [unitImg setValue:@"evolutionchamber.png" forKey:@"Evolution Chamber"];//进化腔
        [unitImg setValue:@"spinecrawler.png" forKey:@"Spine Crawler"];//地堡
        [unitImg setValue:@"sporecrawler.png" forKey:@"Spore Crawler"];//防空
        [unitImg setValue:@"roachwarren.png" forKey:@"Roach Warren"];//蟑螂巢
        [unitImg setValue:@"banelingnest.png" forKey:@"Baneling Nest"];//毒爆虫巢
        [unitImg setValue:@"lair.png" forKey:@"Lair"];//二本
        [unitImg setValue:@"hydraliskden.png" forKey:@"Hydralisk Den"];//口水塔
        [unitImg setValue:@"infestationpit.png" forKey:@"Infestation Pit"];//感染虫巢
        [unitImg setValue:@"spire.png" forKey:@"Spire"];//飞龙塔
        [unitImg setValue:@"greaterspire.png" forKey:@"Greater Spire"];//大龙塔
        [unitImg setValue:@"nydusnetwork.png" forKey:@"Nydus Network"];//传送门
        [unitImg setValue:@"hive.png" forKey:@"Hive"];//三本
        [unitImg setValue:@"ultraliskcavern.png" forKey:@"Ultralisk Cavern"];//牛塔
        [unitImg setValue:@"creeptumor.png" forKey:@"Creep Tumor"];//菌坛瘤
        
        
        [unitImg setValue:@"scv.png" forKey:@"SCV"]; //农民
        [unitImg setValue:@"marine.png" forKey:@"Marine"]; //机枪兵
        [unitImg setValue:@"marauder.png" forKey:@"Marauder"]; //光头
        [unitImg setValue:@"reaper.png" forKey:@"Reaper"]; //死神
        [unitImg setValue:@"ghost.png" forKey:@"Ghost"]; //鬼兵
        [unitImg setValue:@"hellion.png" forKey:@"Hellion"]; //火车
        [unitImg setValue:@"siegetank" forKey:@"Siege Tank"]; //坦克
        [unitImg setValue:@"thor.png" forKey:@"Thor"]; //雷神
        [unitImg setValue:@"viking.png" forKey:@"Viking"]; //维京战机
        [unitImg setValue:@"medivac.png" forKey:@"Medivac"]; //运输机
        [unitImg setValue:@"raven.png" forKey:@"Raven"]; //渡鸦
        [unitImg setValue:@"banshee.png" forKey:@"Banshee"]; //女妖
        [unitImg setValue:@"battlecruiser.png" forKey:@"Battlecruiser"]; //大和
        
        
        [unitImg setValue:@"commandcenter.png" forKey:@"Command Center"]; //基地
        [unitImg setValue:@"orbitalcommand.png" forKey:@"Orbital Command"]; //星轨中心
        [unitImg setValue:@"planetaryfortress.png" forKey:@"Planetary Fortress"]; //行星要塞
        [unitImg setValue:@"supplydepot.png" forKey:@"Supply Depot"]; //房子
        [unitImg setValue:@"refinery.png" forKey:@"Refinery"]; //气矿
        [unitImg setValue:@"barracks.png" forKey:@"Barracks"]; //兵营
        [unitImg setValue:@"engineeringbay.png" forKey:@"Engineering Bay"]; //工程站
        [unitImg setValue:@"bunker.png" forKey:@"Bunker"]; //地堡
        [unitImg setValue:@"missileturret.png" forKey:@"Missile Turret"]; //防空
        [unitImg setValue:@"sensortower.png" forKey:@"Sensor Tower"]; //感应塔
        [unitImg setValue:@"factory.png" forKey:@"Factory"]; //坦克营
        [unitImg setValue:@"ghostacademy.png" forKey:@"Ghost Academy"]; //幽灵研究院
        [unitImg setValue:@"armory.png" forKey:@"Armory"]; //坦克攻防
        [unitImg setValue:@"starport.png" forKey:@"Starport"]; //飞机场
        [unitImg setValue:@"fusioncore.png" forKey:@"Fusion Core"]; //大和建筑
        [unitImg setValue:@"techlab.png" forKey:@"Tech Lab"]; //科技附件
        [unitImg setValue:@"reactor.png" forKey:@"Reactor"]; //双倍附件
        
        
        
        
        
        [unitImg setValue:@"probe.png" forKey:@"Probe"]; //农民
        [unitImg setValue:@"zealot.png" forKey:@"Zealot"]; //叉叉兵
        [unitImg setValue:@"stalker.png" forKey:@"Stalker"]; //追猎
        [unitImg setValue:@"sentry.png" forKey:@"Sentry"]; //哨兵
        [unitImg setValue:@"observer.png" forKey:@"Observer"]; //叮当
        [unitImg setValue:@"immortal.png" forKey:@"Immortal"]; //不朽
        [unitImg setValue:@"warpprism.png" forKey:@"Warp Prism"]; //棱镜  
        [unitImg setValue:@"colossus.png" forKey:@"Colossus"]; //巨像
        [unitImg setValue:@"phoenix.png" forKey:@"Phoenix"]; //凤凰
        [unitImg setValue:@"voidray.png" forKey:@"Void Ray"]; //虚空
        [unitImg setValue:@"hightemplar.png" forKey:@"High Templar"]; //闪电兵
        [unitImg setValue:@"darktemplar.png" forKey:@"Dark Templar"]; //隐刀
        [unitImg setValue:@"archon.png" forKey:@"Archon"]; //白球
        [unitImg setValue:@"carrier.png" forKey:@"Carrier"]; //航母
        [unitImg setValue:@"mothership.png" forKey:@"Mothership"]; //妈妈船
        
        
        [unitImg setValue:@"nexus.png" forKey:@"Nexus"]; //基地
        [unitImg setValue:@"pylon.png" forKey:@"Pylon"]; //水晶
        [unitImg setValue:@"assimilator.png" forKey:@"Assimilator"]; //气矿
        [unitImg setValue:@"gateway.png" forKey:@"Gateway"]; //兵营
        [unitImg setValue:@"forge.png" forKey:@"Forge"]; //锻炉
        [unitImg setValue:@"cyberneticscore.png" forKey:@"Cybernetics Core"]; //控制核心
        [unitImg setValue:@"darkshrine.png" forKey:@"Dark Shrine"]; //隐刀塔
        [unitImg setValue:@"photoncannon.png" forKey:@"Photon Cannon"]; //光子炮
        [unitImg setValue:@"fleetbeacon.png" forKey:@"Fleet Beacon"]; //舰队航标
        [unitImg setValue:@"stargate.png" forKey:@"Stargate"]; //星门
        [unitImg setValue:@"twilightcouncil.png" forKey:@"Twilight Council"]; //暮光议会
        [unitImg setValue:@"roboticsfacility.png" forKey:@"Robotics Facility"]; //机械所
        [unitImg setValue:@"templararchives.png" forKey:@"Templar Archives"]; //圣堂文库
        [unitImg setValue:@"roboticsbay.png" forKey:@"Robotics Bay"];//机械站
        
        //marco
        [unitImg setValue:@"spawnlarva.png" forKey:@"Spawn Larva"];//注卵
        [unitImg setValue:@"chronoboost.png" forKey:@"Chrono Boost"];//星空加速
        [unitImg setValue:@"mule.png" forKey:@"Calldown MULE"];//矿骡
        [unitImg setValue:@"Spawn Creep Tumor.gif" forKey:@"Spawn Creep Tumor"];//菌毯
        
        //research
        //------------------zerg---        
        [unitImg setValue:@"Zerg Burrow.gif" forKey:@"Zerg Burrow"]; //埋地
        [unitImg setValue:@"Zerg Pneumatized Carapace.gif" forKey:@"Zerg Pneumatized Carapace"]; //房子速度
        [unitImg setValue:@"Zerg Ventral Sacs.gif" forKey:@"Zerg Ventral Sacs"]; //房子空投
        
        [unitImg setValue:@"Zerg Metabolic Boost.png" forKey:@"Zerg Metabolic Boost"]; //狗速
        [unitImg setValue:@"Zerg Adrenal Glands.gif" forKey:@"Zerg Adrenal Glands"]; //狂爪   
        
        [unitImg setValue:@"Zerg Centrifugal Hooks.gif" forKey:@"Zerg Centrifugal Hooks"]; //毒爆速度
        
        [unitImg setValue:@"Zerg Glial Reconstitution.gif" forKey:@"Zerg Glial Reconstitution"];//蟑螂速度
        [unitImg setValue:@"Zerg Tunneling Claws.gif" forKey:@"Zerg Tunneling Claws"];//蟑螂埋地
        
        [unitImg setValue:@"Zerg Pathogen Glands.gif" forKey:@"Zerg Pathogen Glands"];//感染能量上限
        [unitImg setValue:@"Zerg Neural Parasite.png" forKey:@"Zerg Neural Parasite"];//感染神经控制
        
        [unitImg setValue:@"Zerg Grooved Spines.gif" forKey:@"Zerg Grooved Spines"];//刺蛇射程
        [unitImg setValue:@"Zerg Chitinous Plating.gif" forKey:@"Zerg Chitinous Plating"];//大牛硬甲
        
        
        //----------------------protoss---------------
        [unitImg setValue:@"Protoss Warp Gate.png" forKey:@"Protoss Warp Gate"];//开门
        [unitImg setValue:@"Protoss Hallucination.png" forKey:@"Protoss Hallucination"];//幻象
        
        [unitImg setValue:@"Protoss Blink.png" forKey:@"Protoss Blink"]; //闪烁科技
        [unitImg setValue:@"Protoss Charge.png" forKey:@"Protoss Charge"]; //zealot脚力
        
        [unitImg setValue:@"Protoss Psionic Storm.png" forKey:@"Protoss Psionic Storm"]; //闪电研究
        
        [unitImg setValue:@"Protoss Gravitic Drive.gif" forKey:@"Protoss Gravitic Drive"]; //棱镜速度
        [unitImg setValue:@"Protoss Gravitic Boosters.gif" forKey:@"Protoss Gravitic Boosters"]; //ob速度
        [unitImg setValue:@"Protoss Extended Thermal Lance.gif" forKey:@"Protoss Extended Thermal Lance"]; //巨像射程
        
        
        //-----------------------terran---------------------
        [unitImg setValue:@"Terran Stimpack.png" forKey:@"Terran Stimpack"]; //兴奋剂
        [unitImg setValue:@"Terran Combat Shield.png" forKey:@"Terran Combat Shield"]; //盾牌
        [unitImg setValue:@"Terran Concussive Shells.png" forKey:@"Terran Concussive Shells"]; //震撼弹
        [unitImg setValue:@"Terran Nitro Packs.png" forKey:@"Terran Nitro Packs"];//死神速度
        
        [unitImg setValue:@"Terran Infernal Pre-Igniter.png" forKey:@"Terran Infernal Pre-Igniter"]; //蓝火
        [unitImg setValue:@"Terran Siege Tech.gif" forKey:@"Terran Siege Tech"]; //坦克架起
        [unitImg setValue:@"Terran 250mm Strike Cannons.png" forKey:@"Terran 250mm Strike Cannons"]; //雷神250
        
        [unitImg setValue:@"Terran Caduceus Reactor.gif" forKey:@"Terran Caduceus Reactor"]; //运输机能量
        [unitImg setValue:@"Terran Corvid Reactor.gif" forKey:@"Terran Corvid Reactor"]; //渡鸦能量
        [unitImg setValue:@"Terran Durable Materials.gif" forKey:@"Terran Durable Materials"]; //无人机研究
        [unitImg setValue:@"Terran Seeker Missile.png" forKey:@"Terran Seeker Missile"]; //渡鸦飞弹
        [unitImg setValue:@"Terran Cloaking Field.png" forKey:@"Terran Cloaking Field"];//女妖隐形
//        
        [unitImg setValue:@"Terran Cloaking Field.png" forKey:@"Terran Personal Cloaking"]; //鬼兵隐形
        [unitImg setValue:@"Terran Moebius Reactor.gif" forKey:@"Terran Moebius Reactor"]; //鬼兵能量
//        
        [unitImg setValue:@"Terran Behemoth Reactor.gif" forKey:@"Terran Behemoth Reactor"]; //大和能量
        [unitImg setValue:@"Terran Weapon Refit.png" forKey:@"Terran Weapon Refit"]; //大和炮
        
        
        
        //upgrade
        
        //-----zerg
        [unitImg setValue:@"Zerg Melee Attacks 1.gif" forKey:@"Zerg Melee Attacks 1"]; //近战攻1
        [unitImg setValue:@"Zerg Melee Attacks 2.gif" forKey:@"Zerg Melee Attacks 2"]; //近战攻2
        [unitImg setValue:@"Zerg Melee Attacks 3.gif" forKey:@"Zerg Melee Attacks 3"]; //近战攻3
        [unitImg setValue:@"Zerg Missile Attacks 1.gif" forKey:@"Zerg Missile Attacks 1"]; //远程攻1
        [unitImg setValue:@"Zerg Missile Attacks 2.gif" forKey:@"Zerg Missile Attacks 2"]; //远程攻2
        [unitImg setValue:@"Zerg Missile Attacks 3.gif" forKey:@"Zerg Missile Attacks 3"]; //远程攻3
        
        [unitImg setValue:@"Zerg Ground Carapace 1.gif" forKey:@"Zerg Ground Carapace 1"]; //防1
        [unitImg setValue:@"Zerg Ground Carapace 2.gif" forKey:@"Zerg Ground Carapace 2"]; //防2
        [unitImg setValue:@"Zerg Ground Carapace 3.gif" forKey:@"Zerg Ground Carapace 3"]; //防3
        
        [unitImg setValue:@"Zerg Flyer Attacks 1.gif" forKey:@"Zerg Flyer Attacks 1"]; //空军攻1
        [unitImg setValue:@"Zerg Flyer Attacks 2.gif" forKey:@"Zerg Flyer Attacks 2"]; //空军攻2
        [unitImg setValue:@"Zerg Flyer Attacks 3.gif" forKey:@"Zerg Flyer Attacks 3"]; //空军攻3
        
        [unitImg setValue:@"Zerg Flyer Carapace 1.gif" forKey:@"Zerg Flyer Carapace 1"]; //空军防1
        [unitImg setValue:@"Zerg Flyer Carapace 2.gif" forKey:@"Zerg Flyer Carapace 2"]; //空军防2
        [unitImg setValue:@"Zerg Flyer Carapace 3.gif" forKey:@"Zerg Flyer Carapace 3"]; //空军防3
        
        //-----terran
        [unitImg setValue:@"Terran Infantry Weapons 1.png" forKey:@"Terran Infantry Weapons 1"]; //生化枪兵攻1
        [unitImg setValue:@"Terran Infantry Weapons 2.png" forKey:@"Terran Infantry Weapons 2"]; //生化枪兵攻2
        [unitImg setValue:@"Terran Infantry Weapons 3.png" forKey:@"Terran Infantry Weapons 3"]; //生化枪兵攻3
        [unitImg setValue:@"Terran Infantry Armor 1.png" forKey:@"Terran Infantry Armor 1"]; //生化枪兵防1
        [unitImg setValue:@"Terran Infantry Armor 2.png" forKey:@"Terran Infantry Armor 2"]; //生化枪兵防2
        [unitImg setValue:@"Terran Infantry Armor 3.png" forKey:@"Terran Infantry Armor 3"]; //生化枪兵防3
        
        [unitImg setValue:@"Terran Vehicle Weapons 1.gif" forKey:@"Terran Vehicle Weapons 1"]; //机械化地面攻1
        [unitImg setValue:@"Terran Vehicle Weapons 2.gif" forKey:@"Terran Vehicle Weapons 2"]; //机械化地面攻2
        [unitImg setValue:@"Terran Vehicle Weapons 3.gif" forKey:@"Terran Vehicle Weapons 3"]; //机械化地面攻3
        [unitImg setValue:@"Terran Vehicle Plating 1.gif" forKey:@"Terran Vehicle Plating 1"]; //机械化地面防1
        [unitImg setValue:@"Terran Vehicle Plating 2.gif" forKey:@"Terran Vehicle Plating 2"]; //机械化地面防2
        [unitImg setValue:@"Terran Vehicle Plating 3.gif" forKey:@"Terran Vehicle Plating 3"]; //机械化地面防3
        
        
        [unitImg setValue:@"Terran Ship Weapons 1.gif" forKey:@"Terran Ship Weapons 1"]; //机械化空中攻1
        [unitImg setValue:@"Terran Ship Weapons 2.gif" forKey:@"Terran Ship Weapons 2"]; //机械化空中攻2
        [unitImg setValue:@"Terran Ship Weapons 3.gif" forKey:@"Terran Ship Weapons 3"]; //机械化空中攻3
        [unitImg setValue:@"Terran Ship Plating 1.gif" forKey:@"Terran Ship Plating 1"]; //机械化空中防1
        [unitImg setValue:@"Terran Ship Plating 2.gif" forKey:@"Terran Ship Plating 2"]; //机械化空中防2
        [unitImg setValue:@"Terran Ship Plating 3.gif" forKey:@"Terran Ship Plating 3"]; //机械化空中防3
        
        //-----protoss
        [unitImg setValue:@"Protoss Ground Weapons 1.gif" forKey:@"Protoss Ground Weapons 1"]; //地面攻1
        [unitImg setValue:@"Protoss Ground Weapons 2.gif" forKey:@"Protoss Ground Weapons 2"]; //地面攻2
        [unitImg setValue:@"Protoss Ground Weapons 3.gif" forKey:@"Protoss Ground Weapons 3"]; //地面攻3
        [unitImg setValue:@"Protoss Ground Armor 1.gif" forKey:@"Protoss Ground Armor 1"]; //地面防1
        [unitImg setValue:@"Protoss Ground Armor 2.gif" forKey:@"Protoss Ground Armor 2"]; //地面防2
        [unitImg setValue:@"Protoss Ground Armor 3.gif" forKey:@"Protoss Ground Armor 3"]; //地面防3
        [unitImg setValue:@"Protoss Shields 1.gif" forKey:@"Protoss Shields 1"]; //护盾1
        [unitImg setValue:@"Protoss Shields 2.gif" forKey:@"Protoss Shields 2"]; //护盾2
        [unitImg setValue:@"Protoss Shields 3.gif" forKey:@"Protoss Shields 3"]; //护盾3
        
        [unitImg setValue:@"Protoss Air Weapons 1.gif" forKey:@"Protoss Air Weapons 1"]; //空军攻1
        [unitImg setValue:@"Protoss Air Weapons 2.gif" forKey:@"Protoss Air Weapons 2"]; //空军攻2
        [unitImg setValue:@"Protoss Air Weapons 3.gif" forKey:@"Protoss Air Weapons 3"]; //空军攻3
        [unitImg setValue:@"Protoss Air Armor 1.gif" forKey:@"Protoss Air Armor 1"]; //空军防1
        [unitImg setValue:@"Protoss Air Armor 2.gif" forKey:@"Protoss Air Armor 2"]; //空军防2
        [unitImg setValue:@"Protoss Air Armor 3.gif" forKey:@"Protoss Air Armor 3"]; //空军防3
        
        
        [_unitInfo setValue:unitImg  forKey:@"unitImg"];
        
        
        //zerg单位建造时间
        NSMutableDictionary *unitDuring = [[NSMutableDictionary alloc]init];
        [unitDuring setValue:@"17" forKey:@"Drone"]; //农民
        [unitDuring setValue:@"25" forKey:@"Overlord"]; //overload
        [unitDuring setValue:@"17" forKey:@"Overseer"];//眼虫
        [unitDuring setValue:@"24" forKey:@"Zergling"]; //狗
        [unitDuring setValue:@"50" forKey:@"Queen"]; //女王
        [unitDuring setValue:@"27" forKey:@"Roach"]; //蟑螂
        [unitDuring setValue:@"33" forKey:@"Hydralisk"];//刺蛇
        [unitDuring setValue:@"20" forKey:@"Baneling"];//毒爆
        [unitDuring setValue:@"50" forKey:@"Infestor"];//感染虫
        [unitDuring setValue:@"33" forKey:@"Mutalisk"];//飞龙
        [unitDuring setValue:@"40" forKey:@"Corruptor"];//腐化
        [unitDuring setValue:@"55" forKey:@"Ultralisk"];//大牛
        [unitDuring setValue:@"34" forKey:@"Brood Lord"];//大龙
        
        
        [unitDuring setValue:@"100" forKey:@"Hatchery"];//基地
        [unitDuring setValue:@"30" forKey:@"Extractor"];//气矿
        [unitDuring setValue:@"65" forKey:@"Spawning Pool"];//血池
        [unitDuring setValue:@"35" forKey:@"Evolution Chamber"];//进化腔
        [unitDuring setValue:@"50" forKey:@"Spine Crawler"];//地堡
        [unitDuring setValue:@"30" forKey:@"Spore Crawler"];//防空
        [unitDuring setValue:@"55" forKey:@"Roach Warren"];//蟑螂巢
        [unitDuring setValue:@"60" forKey:@"Baneling Nest"];//毒爆虫巢
        [unitDuring setValue:@"80" forKey:@"Lair"];//二本
        [unitDuring setValue:@"40" forKey:@"Hydralisk Den"];//口水塔
        [unitDuring setValue:@"50" forKey:@"Infestation Pit"];//感染虫巢
        [unitDuring setValue:@"100" forKey:@"Spire"];//飞龙塔
        [unitDuring setValue:@"100" forKey:@"Greater Spire"];//大龙塔
        [unitDuring setValue:@"50" forKey:@"Nydus Network"];//传送门
        [unitDuring setValue:@"100" forKey:@"Hive"];//三本
        [unitDuring setValue:@"65" forKey:@"Ultralisk Cavern"];//牛塔
        [unitDuring setValue:@"15" forKey:@"Creep Tumor"];//菌坛瘤
        
        
        //人族
        
        [unitDuring setValue:@"17" forKey:@"SCV"]; //农民
        [unitDuring setValue:@"25" forKey:@"Marine"]; //机枪兵
        [unitDuring setValue:@"30" forKey:@"Marauder"]; //光头
        [unitDuring setValue:@"45" forKey:@"Reaper"]; //死神
        [unitDuring setValue:@"40" forKey:@"Ghost"]; //鬼兵
        [unitDuring setValue:@"30" forKey:@"Hellion"]; //火车
        [unitDuring setValue:@"45" forKey:@"Siege Tank"]; //坦克
        [unitDuring setValue:@"60" forKey:@"Thor"]; //雷神
        [unitDuring setValue:@"42" forKey:@"Viking"]; //维京战机
        [unitDuring setValue:@"42" forKey:@"Medivac"]; //运输机
        [unitDuring setValue:@"60" forKey:@"Raven"]; //渡鸦
        [unitDuring setValue:@"60" forKey:@"Banshee"]; //女妖
        [unitDuring setValue:@"90" forKey:@"Battlecruiser"]; //大和
        
        
         [unitDuring setValue:@"100" forKey:@"Command Center"]; //基地
         [unitDuring setValue:@"35" forKey:@"Orbital Command"]; //星轨中心
         [unitDuring setValue:@"50" forKey:@"Planetary Fortress"]; //行星要塞
         [unitDuring setValue:@"30" forKey:@"Supply Depot"]; //房子
         [unitDuring setValue:@"30" forKey:@"Refinery"]; //气矿
         [unitDuring setValue:@"65" forKey:@"Barracks"]; //兵营
         [unitDuring setValue:@"35" forKey:@"Engineering Bay"]; //工程站
         [unitDuring setValue:@"40" forKey:@"Bunker"]; //地堡
         [unitDuring setValue:@"25" forKey:@"Missile Turret"]; //防空
         [unitDuring setValue:@"25" forKey:@"Sensor Tower"]; //感应塔
         [unitDuring setValue:@"60" forKey:@"Factory"]; //坦克营
         [unitDuring setValue:@"40" forKey:@"Ghost Academy"]; //幽灵研究院
         [unitDuring setValue:@"65" forKey:@"Armory"]; //坦克攻防
         [unitDuring setValue:@"50" forKey:@"Starport"]; //飞机场
         [unitDuring setValue:@"65" forKey:@"Fusion Core"]; //大和建筑
         [unitDuring setValue:@"25" forKey:@"Tech Lab"]; //科技附件
         [unitDuring setValue:@"50" forKey:@"Reactor"]; //双倍附件
        
        
        //神族
        [unitDuring setValue:@"17" forKey:@"Probe"]; //农民
        [unitDuring setValue:@"38" forKey:@"Zealot"]; //叉叉兵
        [unitDuring setValue:@"42" forKey:@"Stalker"]; //追猎
        [unitDuring setValue:@"37" forKey:@"Sentry"]; //哨兵
        [unitDuring setValue:@"30" forKey:@"Observer"]; //叮当
        [unitDuring setValue:@"55" forKey:@"Immortal"]; //不朽
        [unitDuring setValue:@"50" forKey:@"Warp Prism"]; //棱镜  
        [unitDuring setValue:@"75" forKey:@"Colossus"]; //巨像
        [unitDuring setValue:@"35" forKey:@"Phoenix"]; //凤凰
        [unitDuring setValue:@"60" forKey:@"Void Ray"]; //虚空
        [unitDuring setValue:@"55" forKey:@"High Templar"]; //闪电兵
        [unitDuring setValue:@"55" forKey:@"Dark Templar"]; //隐刀
        [unitDuring setValue:@"12" forKey:@"Archon"]; //和白球
        [unitDuring setValue:@"120" forKey:@"Carrier"]; //航母
        [unitDuring setValue:@"160" forKey:@"Mothership"]; //妈妈船
        
        
        [unitDuring setValue:@"100" forKey:@"Nexus"]; //基地
//        [unitDuring setValue:@"5" forKey:@"Nexus"]; //基地
        [unitDuring setValue:@"25" forKey:@"Pylon"]; //水晶
        [unitDuring setValue:@"30" forKey:@"Assimilator"]; //气矿
        [unitDuring setValue:@"65" forKey:@"Gateway"]; //兵营
        [unitDuring setValue:@"15" forKey:@"Warp Gate"];//传送门
        [unitDuring setValue:@"45" forKey:@"Forge"]; //锻炉
        [unitDuring setValue:@"50" forKey:@"Cybernetics Core"]; //控制核心
        [unitDuring setValue:@"100" forKey:@"Dark Shrine"]; //隐刀塔
        [unitDuring setValue:@"40" forKey:@"Photon Cannon"]; //光子炮
        [unitDuring setValue:@"60" forKey:@"Fleet Beacon"]; //舰队航标
        [unitDuring setValue:@"60" forKey:@"Stargate"]; //星门
        [unitDuring setValue:@"50" forKey:@"Twilight Council"]; //暮光议会
        [unitDuring setValue:@"65" forKey:@"Robotics Facility"]; //机械所
        [unitDuring setValue:@"50" forKey:@"Templar Archives"]; //圣堂文库
        [unitDuring setValue:@"65" forKey:@"Robotics Bay"];//机械站
        
        //research
        
        //-----zerg
        
        [unitDuring setValue:@"100" forKey:@"Zerg Burrow"]; //埋地
        [unitDuring setValue:@"60" forKey:@"Zerg Pneumatized Carapace"]; //房子速度
        [unitDuring setValue:@"130" forKey:@"Zerg Ventral Sacs"]; //房子空投
        
        [unitDuring setValue:@"110" forKey:@"Zerg Metabolic Boost"]; //狗速
        [unitDuring setValue:@"130" forKey:@"Zerg Adrenal Glands"]; //狂爪
        
        [unitDuring setValue:@"110" forKey:@"Zerg Centrifugal Hooks"]; //毒爆速度
        [unitDuring setValue:@"110" forKey:@"Zerg Glial Reconstitution"];//蟑螂速度
        [unitDuring setValue:@"110" forKey:@"Zerg Tunneling Claws"];//蟑螂埋地
        
        [unitDuring setValue:@"80" forKey:@"Zerg Pathogen Glands"];//感染能量上限
        [unitDuring setValue:@"110" forKey:@"Zerg Neural Parasite"];//感染神经控制
        
        [unitDuring setValue:@"80" forKey:@"Zerg Grooved Spines"];//刺蛇射程
        
        [unitDuring setValue:@"110" forKey:@"Zerg Chitinous Plating"];//大牛硬甲

        
        //----protoss
        [unitDuring setValue:@"160" forKey:@"Protoss Warp Gate"]; //兵营开门研究
        [unitDuring setValue:@"80" forKey:@"Protoss Hallucination"]; //幻象
        
        [unitDuring setValue:@"140" forKey:@"Protoss Blink"]; //闪烁科技
        [unitDuring setValue:@"140" forKey:@"Protoss Charge"]; //zealot脚力
        
        [unitDuring setValue:@"110" forKey:@"Protoss Psionic Storm"]; //闪电研究
        
        [unitDuring setValue:@"80" forKey:@"Protoss Gravitic Drive"]; //棱镜速度
        [unitDuring setValue:@"80" forKey:@"Protoss Gravitic Boosters"]; //ob速度
        [unitDuring setValue:@"140" forKey:@"Protoss Extended Thermal Lance"]; //巨像射程
    
        
        //-----terran
        [unitDuring setValue:@"170" forKey:@"Terran Stimpack"]; //兴奋剂
        [unitDuring setValue:@"110" forKey:@"Terran Combat Shield"]; //盾牌
        [unitDuring setValue:@"60" forKey:@"Terran Concussive Shells"]; //震撼弹
        [unitDuring setValue:@"100" forKey:@"Terran Nitro Packs"];//死神速度
        
        [unitDuring setValue:@"110" forKey:@"Terran Infernal Pre-Igniter"]; //蓝火
        [unitDuring setValue:@"80" forKey:@"Terran Siege Tech"]; //坦克架起
        [unitDuring setValue:@"110" forKey:@"Terran 250mm Strike Cannons"]; //雷神250
        
        [unitDuring setValue:@"80" forKey:@"Terran Caduceus Reactor"]; //运输机能量
        [unitDuring setValue:@"110" forKey:@"Terran Corvid Reactor"]; //渡鸦能量
        [unitDuring setValue:@"110" forKey:@"Terran Durable Materials"]; //无人机研究
        [unitDuring setValue:@"110" forKey:@"Terran Seeker Missile"]; //渡鸦飞弹
        [unitDuring setValue:@"110" forKey:@"Terran Cloaking Field"];//女妖隐形
        
        [unitDuring setValue:@"120" forKey:@"Terran Personal Cloaking"]; //鬼兵隐形
        [unitDuring setValue:@"80" forKey:@"Terran Moebius Reactor"]; //鬼兵能量
        
        [unitDuring setValue:@"80" forKey:@"Terran Behemoth Reactor"]; //大和能量
        [unitDuring setValue:@"60" forKey:@"Terran Weapon Refit"]; //大和炮

        
        //upgrade
        //------zerg----
        [unitDuring setValue:@"160" forKey:@"Zerg Melee Attacks 1"]; //近战攻1
        [unitDuring setValue:@"190" forKey:@"Zerg Melee Attacks 2"]; //近战攻2
        [unitDuring setValue:@"220" forKey:@"Zerg Melee Attacks 3"]; //近战攻3
        [unitDuring setValue:@"160" forKey:@"Zerg Missile Attacks 1"]; //远程攻1
        [unitDuring setValue:@"190" forKey:@"Zerg Missile Attacks 2"]; //远程攻2
        [unitDuring setValue:@"220" forKey:@"Zerg Missile Attacks 3"]; //远程攻3
        
        [unitDuring setValue:@"160" forKey:@"Zerg Ground Carapace 1"]; //防1
        [unitDuring setValue:@"190" forKey:@"Zerg Ground Carapace 2"]; //防2
        [unitDuring setValue:@"220" forKey:@"Zerg Ground Carapace 3"]; //防3
        
        [unitDuring setValue:@"160" forKey:@"Zerg Flyer Attacks 1"]; //空军攻1
        [unitDuring setValue:@"190" forKey:@"Zerg Flyer Attacks 2"]; //空军攻2
        [unitDuring setValue:@"220" forKey:@"Zerg Flyer Attacks 3"]; //空军攻3
        
        [unitDuring setValue:@"160" forKey:@"Zerg Flyer Carapace 1"]; //空军防1
        [unitDuring setValue:@"190" forKey:@"Zerg Flyer Carapace 2"]; //空军防2
        [unitDuring setValue:@"220" forKey:@"Zerg Flyer Carapace 3"]; //空军防3
        
        
       
        //------protoss---
        [unitDuring setValue:@"160" forKey:@"Protoss Ground Weapons 1"]; //地面攻1
        [unitDuring setValue:@"190" forKey:@"Protoss Ground Weapons 2"]; //地面攻2
        [unitDuring setValue:@"220" forKey:@"Protoss Ground Weapons 3"]; //地面攻3
        [unitDuring setValue:@"160" forKey:@"Protoss Ground Armor 1"]; //地面防1
        [unitDuring setValue:@"190" forKey:@"Protoss Ground Armor 2"]; //地面防2
        [unitDuring setValue:@"220" forKey:@"Protoss Ground Armor 3"]; //地面防3
        [unitDuring setValue:@"160" forKey:@"Protoss Shields 1"]; //护盾1
        [unitDuring setValue:@"190" forKey:@"Protoss Shields 2"]; //护盾2
        [unitDuring setValue:@"220" forKey:@"Protoss Shields 3"]; //护盾3
        
        [unitDuring setValue:@"160" forKey:@"Protoss Air Weapons 1"]; //空军攻1
        [unitDuring setValue:@"190" forKey:@"Protoss Air Weapons 2"]; //空军攻2
        [unitDuring setValue:@"220" forKey:@"Protoss Air Weapons 3"]; //空军攻3
        [unitDuring setValue:@"160" forKey:@"Protoss Air Armor 1"]; //空军防1
        [unitDuring setValue:@"190" forKey:@"Protoss Air Armor 2"]; //空军防2
        [unitDuring setValue:@"220" forKey:@"Protoss Air Armor 3"]; //空军防3
        
        
        //-----terran---
        [unitDuring setValue:@"160" forKey:@"Terran Infantry Weapons 1"]; //生化枪兵攻1
        [unitDuring setValue:@"190" forKey:@"Terran Infantry Weapons 2"]; //生化枪兵攻2
        [unitDuring setValue:@"220" forKey:@"Terran Infantry Weapons 3"]; //生化枪兵攻3
        [unitDuring setValue:@"160" forKey:@"Terran Infantry Armor 1"]; //生化枪兵防1
        [unitDuring setValue:@"190" forKey:@"Terran Infantry Armor 2"]; //生化枪兵防2
        [unitDuring setValue:@"220" forKey:@"Terran Infantry Armor 3"]; //生化枪兵防3
        
        
        [unitDuring setValue:@"160" forKey:@"Terran Vehicle Weapons 1"]; //机械化地面攻1
        [unitDuring setValue:@"190" forKey:@"Terran Vehicle Weapons 2"]; //机械化地面攻2
        [unitDuring setValue:@"220" forKey:@"Terran Vehicle Weapons 3"]; //机械化地面攻3
        [unitDuring setValue:@"160" forKey:@"Terran Vehicle Plating 1"]; //机械化地面防1
        [unitDuring setValue:@"190" forKey:@"Terran Vehicle Plating 2"]; //机械化地面防2
        [unitDuring setValue:@"220" forKey:@"Terran Vehicle Plating 3"]; //机械化地面防3
        
       
        [unitDuring setValue:@"160" forKey:@"Terran Ship Weapons 1"]; //机械化空中攻1
        [unitDuring setValue:@"190" forKey:@"Terran Ship Weapons 2"]; //机械化空中攻2
        [unitDuring setValue:@"220" forKey:@"Terran Ship Weapons 3"]; //机械化空中攻3
        [unitDuring setValue:@"160" forKey:@"Terran Ship Plating 1"]; //机械化空中防1
        [unitDuring setValue:@"190" forKey:@"Terran Ship Plating 2"]; //机械化空中防2
        [unitDuring setValue:@"220" forKey:@"Terran Ship Plating 3"]; //机械化空中防3
    
        
        [_unitInfo setValue:unitDuring  forKey:@"unitDuring"];
         NSMutableDictionary *unitcost = [[NSMutableDictionary alloc]init];
        
        [unitcost setValue:@"1" forKey:@"Drone"]; //农民
        [unitcost setValue:@"0" forKey:@"Overlord"]; //overload
        [unitcost setValue:@"1" forKey:@"Zergling"]; //狗
        [unitcost setValue:@"2" forKey:@"Queen"]; //女王
        [unitcost setValue:@"2" forKey:@"Roach"]; //蟑螂
        [unitcost setValue:@"2" forKey:@"Hydralisk"];//刺蛇
        [unitcost setValue:@"0" forKey:@"Baneling"];//毒爆
        [unitcost setValue:@"2" forKey:@"Infestor"];//感染虫
        [unitcost setValue:@"2" forKey:@"Mutalisk"];//飞龙
        [unitcost setValue:@"2" forKey:@"Corruptor"];//腐化
        [unitcost setValue:@"6" forKey:@"Ultralisk"];//大牛
        [unitcost setValue:@"0" forKey:@"Brood Lord"];//大龙
        
        [unitcost setValue:@"1" forKey:@"SCV"]; //农民
        [unitcost setValue:@"1" forKey:@"Marine"]; //机枪兵
        [unitcost setValue:@"2" forKey:@"Marauder"]; //光头
        [unitcost setValue:@"1" forKey:@"Reaper"]; //死神
        [unitcost setValue:@"2" forKey:@"Ghost"]; //鬼兵
        [unitcost setValue:@"2" forKey:@"Hellion"]; //火车
        [unitcost setValue:@"3" forKey:@"Siege Tank"]; //坦克
        [unitcost setValue:@"6" forKey:@"Thor"]; //雷神
        [unitcost setValue:@"2" forKey:@"Viking"]; //维京战机
        [unitcost setValue:@"2" forKey:@"Medivac"]; //运输机
        [unitcost setValue:@"2" forKey:@"Raven"]; //渡鸦
        [unitcost setValue:@"3" forKey:@"Banshee"]; //女妖
        [unitcost setValue:@"6" forKey:@"Battlecruiser"]; //大和
        
        
        [unitcost setValue:@"1" forKey:@"Probe"]; //农民
        [unitcost setValue:@"2" forKey:@"Zealot"]; //叉叉兵
        [unitcost setValue:@"2" forKey:@"Stalker"]; //追猎
        [unitcost setValue:@"2" forKey:@"Sentry"]; //哨兵
        [unitcost setValue:@"1" forKey:@"Observer"]; //叮当
        [unitcost setValue:@"4" forKey:@"Immortal"]; //不朽
        [unitcost setValue:@"2" forKey:@"Warp Prism"]; //棱镜  
        [unitcost setValue:@"6" forKey:@"Colossus"]; //巨像
        [unitcost setValue:@"2" forKey:@"Phoenix"]; //凤凰
        [unitcost setValue:@"3" forKey:@"Void Ray"]; //虚空
        [unitcost setValue:@"2" forKey:@"High Templar"]; //闪电兵
        [unitcost setValue:@"2" forKey:@"Dark Templar"]; //隐刀
        [unitcost setValue:@"0" forKey:@"Archon"]; //和白球
        [unitcost setValue:@"6" forKey:@"Carrier"]; //航母
        [unitcost setValue:@"8" forKey:@"Mothership"]; //妈妈船
        
        [_unitInfo setValue:unitcost  forKey:@"unitcost"];
        
        NSMutableDictionary *supplesadd = [[NSMutableDictionary alloc]init];
        [supplesadd setValue:@"8" forKey:@"Overlord"];
        [supplesadd setValue:@"8" forKey:@"Supply Depot"];
        [supplesadd setValue:@"8" forKey:@"Pylon"];
        [supplesadd setValue:@"2" forKey:@"Hatchery"];
        [supplesadd setValue:@"10" forKey:@"Nexus"];
        [supplesadd setValue:@"11" forKey:@"Command Center"];
        
        [_unitInfo setValue:supplesadd  forKey:@"supplesadd"];
    }
    return self;
}

-(int)supplyAddAfterBuild:(NSString *)tag{
    NSMutableDictionary *supplesadd  = [_unitInfo objectForKey:@"supplesadd"];
    if ([supplesadd objectForKey:tag]) {
        return [[supplesadd objectForKey:tag]intValue];
    }else return 0;
}

-(int)UnitCost:(NSString *)tag{
    NSMutableDictionary *unitcost  = [_unitInfo objectForKey:@"unitcost"];
    if ([unitcost objectForKey:tag]) {
       return [[unitcost objectForKey:tag]intValue];
    }else return 0;
}



-(int)UnitAddAfterProduce:(NSString *)tag{
    if ([tag isEqualToString:@"Zergling"]) {
        return 2;
    }else return 1;
}

//单位建造时间间隔
-(int)UnitDuringByNode:(SC2ReplayNode *)node{
    if ([node.nodeType isEqualToString:@"TrainWarpGate"]) {
        return 5;
    }
    else{
        NSMutableDictionary *unitDuring  = [_unitInfo objectForKey:@"unitDuring"];
        return  [[unitDuring objectForKey:node.nodeUnit]intValue];
    }
}

//单位建造时间间隔
-(int)UnitDuringByTag:(NSString *)tag{
    NSMutableDictionary *unitDuring  = [_unitInfo objectForKey:@"unitDuring"];
    return  [[unitDuring objectForKey:tag]intValue];
}

-(UIImage *)UnitImageBytag:(NSString *)tag{
    NSMutableDictionary *unitImg  = [_unitInfo objectForKey:@"unitImg"];
    if ([unitImg objectForKey:tag]) {
         return [UIImage imageNamed:[unitImg objectForKey:tag]];
    }
    else return [UIImage imageNamed:@"icon-zerg.png"];
}

@end
