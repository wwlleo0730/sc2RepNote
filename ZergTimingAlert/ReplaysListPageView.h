//
//  ReplaysListPageView.h
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-7.
//  Copyright (c) 2012年 esse. All rights reserved.
//

@interface ReplaysListPageView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *repTable;
@property (nonatomic,strong) NSArray *replays;

@property (nonatomic,strong) NSString *key;
@property (nonatomic,assign) int itemType;
@property (nonatomic,strong) NSArray *allReps;

-(NSArray *)getReplaysByKeyAndType:(int)type key:(NSString *)key;//对战分类的reps

@end
