//
//  Globals.h
//  EsseUIProject
//
//  Created by wwl on 11-12-22.
//  Copyright 2011年 esse. All rights reserved.
//

#ifndef EsseUIProject_Globals_h
#define EsseUIProject_Globals_h

#define theSC2App ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kNumberOfPages 1


#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kLauncherBtnSize 48
#define alertViewHeight 5
#define alertViewMargin 5

#define buildingViewHeight 310
#define unitSpace 50

#define kNumOfLine         6
#define kNumOfPage         9



//=================== totalinfo中设置table的高度值
#define closeCellHeight 50
#define openCellHeight 295
#define totalTableMargin 20


//沙盒路径
//用户自建文件
#define kPersonalPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//用户临时文件
#define kDocmnentPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kFujiansPath [kDocmnentPath stringByAppendingPathComponent:allFujianFile]
#define appFileName @"sc2BaseData.plist"
#define agreeTag @"agree"
#define backTag @"back"
#define refuseTag @"refuse"
#define AuthenTag @"authen"
#define baseUrlTag @"baseurl"
#define fontSizeTag @"fontsize"
//附件截图的后缀
#define fujianSuffix @"shot.jpg"


//cell里table信息显示参数
#define titlelabelSize 15.0f      //字体大小
#define labelHeight 20      //行高
#define leftTitleLableX 5   //左边标题横坐标
#define TitleLableWidth 95  //标题内容宽度
#define InfoLableWidth 200  //（左边）内容宽度


#define progressbgcolor 0x8cbf26 //草绿
#define unitshowbgcolor 0xde9317 //桔黄

#define metropurple 0x5859b9
#define metroorange 0xde9317
#define metrored 0xd54d34



//game util
#define basegamespeed 0.717
#define gamespeed 0.717

//zerg unit
#define zergunit @"zergunit"

#define drone @"Drone"
#define overload @"Overload"
#define zergling @"Zergling"
#define queen @"Queen"
#define roach @"Roach"
#define hydralisk @"Hydralisk"
#define baneling @"Baneling"

//zerg building
#define zergbuilding @"zergbuilding"
#define spawningpool @"spawningpool"

//protoss building
#define protossunit @"protossunit"
#define probe @"probe"
#define zealot @"zealot"

//terran building
#define terranunit @"terranunit"
#define scv @"scv"
#define marine @"marine"


//fight type
#define zvp @"zvp"
#define zvt @"zvt"
#define zvz @"zvz"
#define pvz @"pvz"
#define pvp @"pvp"
#define pvt @"pvt"
#define tvz @"tvz"
#define tvp @"tvp"
#define tvt @"tvt"


//rep json格式专用信息

#define repplayer @"repplayer"
#define mapname @"mapname"
#define fighttype @"fighttype"
#define repaction @"repaction"




#endif
