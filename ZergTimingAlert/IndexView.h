//
//  IndexView.h
//  ZergTimingAlert
//
//  Created by wwl on 12-4-1.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTabView.h"
//#import "MKHorizMenu.h"

@interface IndexView : UIViewController<UITableViewDelegate,UITableViewDataSource,JMTabViewDelegate>{
//    MKHorizMenuDataSource, MKHorizMenuDelegate>{
}

@property (nonatomic, strong) NSMutableArray *documentURLs;
@property (nonatomic,strong) UITableView *indexTable;
@property (nonatomic,strong) NSMutableArray *indexData1;
@property (nonatomic,strong) NSArray *indexData2;
@property (nonatomic,strong) NSArray *indexData3;

@property (nonatomic,strong) NSArray *indexData;
@property (nonatomic,strong) NSMutableArray *replaysArray;

@property (nonatomic,assign) int itemKey;


//@property (nonatomic,strong) MKHorizMenu *horizMenu;
@property (nonatomic,strong) NSMutableArray *tabItems;


//@property (nonatomic,strong) ADBannerView *adView;
-(void)prePareIndexData:(NSUInteger)itemIndex;
@end
