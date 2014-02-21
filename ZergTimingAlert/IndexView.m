//
//  IndexView.m
//  ZergTimingAlert
//
//  Created by wwl on 12-4-1.
//  Copyright (c) 2012年 esse. All rights reserved.
//

#import "IndexView.h"
#import "RepShowPage.h"
#import "JMTabView.h"
#import "ReplaysListPageView.h"
#import "SC2ReplayUtil.h"

@implementation IndexView

@synthesize indexTable = _indexTable;

@synthesize indexData = _indexData;
@synthesize replaysArray = _replaysArray;

@synthesize indexData1 = _indexData1;
@synthesize indexData2 = _indexData2;
@synthesize indexData3 = _indexData3;

@synthesize itemKey = _itemKey;
//@synthesize adView = _adView;

//@synthesize horizMenu = _horizMenu;
@synthesize tabItems = _tabItems;

#pragma mark - View lifecycle

//--------------------------

-(void)addStandardTabView;
{
    
    JMTabView * tabView = [[JMTabView alloc] initWithFrame:CGRectMake(0, 460-44, self.view.bounds.size.width, 44)];
    
    [tabView setDelegate:self];
    [tabView addTabItemWithTitle:NSLocalizedString(@"Players",nil) icon:nil];
    [tabView addTabItemWithTitle:NSLocalizedString(@"Fighting Type",nil) icon:nil];
    [tabView addTabItemWithTitle:NSLocalizedString(@"Maps",nil) icon:nil];
    [tabView setSelectedIndex:0];
    [self prePareIndexData:0];
    [self.view addSubview:tabView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
{
    [self prePareIndexData:itemIndex];
    [self.indexTable reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

//准备数据
-(void)prePareIndexData:(NSUInteger)itemIndex{
    //根据选手分
    if (itemIndex == 0) {
        _indexData = _indexData1;
        _itemKey = 0;
    }
    //根据对战类型
    else if(itemIndex == 1){
        _indexData = _indexData2; 
        _itemKey = 1;
    }
    //根据地图
    else if(itemIndex == 2){
        _indexData = _indexData3;
        _itemKey = 2;
    }else{
    
    }
}




- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *playersPath=[[NSBundle mainBundle] pathForResource:@"players" ofType:@"plist"];
    NSMutableDictionary *players = [[NSMutableDictionary alloc]initWithContentsOfFile:playersPath];
        
    NSArray *zergPlayer = [players objectForKey:@"zerg"];
    NSArray *protossPlayer = [players objectForKey:@"protoss"];
    NSArray *terranPlayer = [players objectForKey:@"terran"];
    
    _indexData1 = [[NSMutableArray alloc]init];
    
    for (NSString *k in zergPlayer) {
        [_indexData1 addObject:k]; 
    }
    for (NSString *k in protossPlayer) {
        [_indexData1 addObject:k]; 
    }
    for (NSString *k in terranPlayer) {
        [_indexData1 addObject:k]; 
    }
    
    _indexData2 = [[NSMutableArray alloc]initWithObjects:@"zvp",@"zvt",@"pvt",@"pvz",@"tvz",@"tvp", nil];
    
    _indexData3 = [[NSMutableArray alloc]initWithObjects:@"Cloud Kingdom",@"Daybreak",@"Ohana",@"Antiga Shipyard",@"Entombed Valley",@"Shakuras Plateau",@"Tal Darim Altar",@"Metropolis",@"Metalopolis",@"Atlantis Spaceship", nil];
    [self addStandardTabView];
        
    _indexTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStyleGrouped];
    _indexTable.delegate = self;
    _indexTable.dataSource = self;
    _indexTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _indexTable.separatorColor = [UIColor groupTableViewBackgroundColor];
    _indexTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_indexTable];
    
}


//section num
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_indexData count];   
    
}

//定义cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 55;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.textColor = HEXCOLOR(0x3e4146);//0x6e6d75
    
    cell.textLabel.textColor = HEXCOLOR(metropurple);
    
    
    NSString *k = [_indexData objectAtIndex:indexPath.row];
    cell.textLabel.text = NSLocalizedString(k,nil);

    NSString *race = [[SC2ReplayUtil getSc2ReplayUtil] getRaceByPlayerName:k];
    cell.detailTextLabel.text = NSLocalizedString(race,nil);
    cell.detailTextLabel.textColor = HEXCOLOR(0x3e4146);
    if ([race isEqualToString:@"terran"]) {
        cell.imageView.image = [UIImage imageNamed:@"terran.gif"];
    }
    else if ([race isEqualToString:@"zerg"]) {
        cell.imageView.image = [UIImage imageNamed:@"zerg.gif"];
    }
    else if ([race isEqualToString:@"protoss"]) {
        cell.imageView.image = [UIImage imageNamed:@"protoss.gif"];
    }else{
        cell.imageView.image = nil;
    }
    
//    if (![race isEqualToString:@""]) {
//        
//        NSLog(@">%@",race);
//        
//        cell.detailTextLabel.text = NSLocalizedString(race,nil);
//        cell.detailTextLabel.textColor = HEXCOLOR(metropurple);
//        if ([race isEqualToString:@"terran"]) {
//            cell.imageView.image = [UIImage imageNamed:@"terran.gif"];
//        }
//        else if ([race isEqualToString:@"zerg"]) {
//            cell.imageView.image = [UIImage imageNamed:@"zerg.gif"];
//        }
//        else if ([race isEqualToString:@"protoss"]) {
//            cell.imageView.image = [UIImage imageNamed:@"protoss.gif"];
//        }else{
//        
//        }
//    }
    
//    int myrow = indexPath.row;
//    if (indexPath.section == 0) {
//        cell.textLabel.text = [_zergPlayers objectAtIndex:myrow];
//    }else if(indexPath.section == 1){
//        cell.textLabel.text = [_protossPlayers objectAtIndex:myrow];
//    }else if(indexPath.section == 2){
//        cell.textLabel.text = [_terranPlayers objectAtIndex:myrow];
//    }else{
//        cell.textLabel.text = @"";
//        NSURL *fileURL =  [self.documentURLs objectAtIndex:indexPath.row];
//        cell.textLabel.text = [[fileURL path] lastPathComponent];
//    }
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    cell.backgroundColor = [UIColor whiteColor];
    
//    if (indexPath.section == 0) {
//        cell.backgroundColor = HEXCOLOR(metropurple);
//    }else if(indexPath.section == 1){
//        cell.backgroundColor = HEXCOLOR(metroorange);
//    }else if(indexPath.section == 2){
//        cell.backgroundColor = HEXCOLOR(metrored);
//    }else{
//        cell.backgroundColor = HEXCOLOR(progressbgcolor);
//    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key = [_indexData objectAtIndex:indexPath.row];
    
    ReplaysListPageView *replayList = [[ReplaysListPageView alloc]init];
    replayList.key = key;
    replayList.itemType = _itemKey;
    [self.navigationController pushViewController:replayList animated:YES];
//    NSString *playerName = @"";
//    NSString *race = @"";
//    int myrow = indexPath.row;
//    if (indexPath.section == 0) {
//        playerName = [_zergPlayers objectAtIndex:myrow];
//        race = @"zerg";
//    }else if(indexPath.section == 1){
//        playerName = [_protossPlayers objectAtIndex:myrow];
//        race = @"protoss";
//    }else if(indexPath.section == 2){
//        playerName = [_terranPlayers objectAtIndex:myrow];
//        race = @"terran";
//    }else{
//        playerName = @"";
//        race = @"";
//    }
//    PersonalPageView *personalPage = [[PersonalPageView alloc]init];
//    personalPage.race = race;
//    personalPage.player = playerName;
//    [self.navigationController pushViewController:personalPage animated:YES];
////    RepShowPage *repPage =  [[RepShowPage alloc]initWithNibName:@"RepShowPage" bundle:nil];
////    repPage.repPlayer = playerName;
////    repPage.replayName = @"stephanozvp1";
////    [self.navigationController pushViewController:repPage animated:YES];
}


#pragma mark -
#pragma mark File system support

//- (NSString *)applicationDocumentsDirectory
//{
//	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//}

//- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
//{
//	[self.documentURLs removeAllObjects];    // clear out the old docs and start over
//	
//	NSString *documentsDirectoryPath = [self applicationDocumentsDirectory];
//	NSArray *documentsDirectoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:NULL];
//    
//	for (NSString* curFileName in [documentsDirectoryContents objectEnumerator])
//	{
//		NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:curFileName];
//		NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//		
//		BOOL isDirectory;
//        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
//		
//        // proceed to add the document URL to our list (ignore the "Inbox" folder)
//        if (!(isDirectory && [curFileName isEqualToString: @"Inbox"]))
//        {
//            [self.documentURLs addObject:fileURL];
//        }
//	}
//	
//	[self.indexTable reloadData];
//}



//#pragma mark -
//#pragma mark HorizMenu Data Source
//- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
//{
//    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
//}
//
//- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
//{
//    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
//}
//
//- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
//{
//    return [self.tabItems count];
//}
//
//- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
//{
//    return [self.tabItems objectAtIndex:index];
//}
//
//#pragma mark -
//#pragma mark HorizMenu Delegate
//-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
//{        
//    [self prePareIndexData:index];
//    [self.indexTable reloadData];
//    //self.selectionItemLabel.text = [self.tabItems objectAtIndex:index];
//}

@end
