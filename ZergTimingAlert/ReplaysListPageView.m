//
//  ReplaysListPageView.m
//  sc2RepNote
//
//  Created by 文立 吴 on 12-7-7.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "ReplaysListPageView.h"
#import "RepShowPage.h"
#import "SC2Replay.h"
#import "SC2ReplayUtil.h"

@implementation ReplaysListPageView

@synthesize repTable = _repTable;
@synthesize replays = _replays;
@synthesize key = _key;
@synthesize itemType = _itemType;
@synthesize allReps = _allReps;


-(NSArray *)doSetRepsByKeyAndPlayer:(NSString *)key{
    NSMutableArray *reps = [[NSMutableArray alloc]init];
    for (SC2Replay *rep in [SC2ReplayUtil getSc2ReplayUtil].allReplays) {
        if ([rep.repPlayer isEqualToString:key]) {
            [reps addObject:rep];
        }
    }
    return reps;
}

-(NSArray *)doSetRepsByKeyAndFightType:(NSString *)key{
    NSMutableArray *reps = [[NSMutableArray alloc]init];
    for (SC2Replay *rep in [SC2ReplayUtil getSc2ReplayUtil].allReplays) {
        if ([rep.fightType isEqualToString:key]) {
            [reps addObject:rep];
        }
    }
    return reps;
}

-(NSArray *)doSetRepsByKeyAndMap:(NSString *)key{
    NSMutableArray *reps = [[NSMutableArray alloc]init];
    for (SC2Replay *rep in [SC2ReplayUtil getSc2ReplayUtil].allReplays) {
        if ([rep.mapName isEqualToString:key]) {
            [reps addObject:rep];
        }
    }
    return reps;
}

-(NSArray *)getReplaysByKeyAndType:(int)type key:(NSString *)key{
    if (type == 0) 
        return [self doSetRepsByKeyAndPlayer:key];
    else if(type == 1)
        return [self doSetRepsByKeyAndFightType:key];
    else if(type == 2)
        return [self doSetRepsByKeyAndMap:key];
    else return nil;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
     self.navigationController.navigationBarHidden = NO;
    _repTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44) style:UITableViewStyleGrouped];
    _repTable.delegate = self;
    _repTable.dataSource = self;
    _repTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _repTable.separatorColor = [UIColor groupTableViewBackgroundColor];
    _repTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_repTable];
    _replays = [self getReplaysByKeyAndType:_itemType key:_key];
}

//section num
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_replays count];
}

//定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 55;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 55;
//}

////fix bug for ios4.3
////@ 2012 0801
////Prior to iOS 5.0, table views would automatically resize the heights of headers to 0 for sections where tableView:viewForHeaderInSection: returned a nil view. In iOS 5.0 and later, you must return the actual height for each section header in this method.
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [[UIView alloc]init];
//}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor whiteColor];
//    cell.backgroundColor = HEXCOLOR(metropurple);
//    if ([_race isEqualToString:@"zerg"]) {
//        cell.backgroundColor = HEXCOLOR(metropurple);
//    }else if ([_race isEqualToString:@"protoss"]) {
//        cell.backgroundColor = HEXCOLOR(metroorange);
//    }else cell.backgroundColor = HEXCOLOR(metrored);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        UITableViewCell *cell = nil;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:nil];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
//        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = HEXCOLOR(metropurple);
    
//       cell.imageView.image = [UIImage imageNamed:@"sc2repImg.png"];
        SC2Replay *rep = [_replays objectAtIndex:indexPath.row];
        NSString *title = [[NSString alloc]initWithFormat:@"%@ %@ on %@",rep.repPlayer,rep.fightType,NSLocalizedString(rep.mapName,nil)];
        cell.textLabel.text = title;
        
        cell.detailTextLabel.textColor = HEXCOLOR(0x3e4146);
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = [[NSString alloc]initWithFormat:@"%@ : %@\n%@ : %@",NSLocalizedString(@"About",nil),rep.repInfo,NSLocalizedString(@"Strategy",nil),NSLocalizedString(rep.repStrategy,nil)];
        
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        SC2Replay *rep = [_replays objectAtIndex:indexPath.row];
        RepShowPage *repPage =  [[RepShowPage alloc]initWithNibName:@"RepShowPage" bundle:nil];        
        repPage.replay = rep;

//        [self presentModalViewController:repPage animated:YES];
        [self.navigationController pushViewController:repPage animated:YES];
}

@end
