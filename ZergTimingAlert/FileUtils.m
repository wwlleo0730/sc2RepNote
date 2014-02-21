//
//  FileUtils.m
//  BPMDaheIphone
//
//  Created by wwl on 12-1-11.
//  Copyright 2012年 esse. All rights reserved.
//

#import "FileUtils.h"
#import "Globals.h"


@implementation FileUtils


-(id)init
{
    self = [super init];
    if (self) {
        //NSLog(@"file utility");
        filemanager = [NSFileManager defaultManager];
    }
    return  self;
}

-(Boolean)isFileExisted:(NSString *)pathName{
    return [filemanager fileExistsAtPath:pathName]; 
}


-(Boolean)createProtectedPlistFile:(NSString *)plistPath{
    NSDictionary *attr = [[NSDictionary alloc]initWithContentsOfFile:NSFileProtectionComplete];
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]init];
        //配置默认URL
    Boolean r = [filemanager createFileAtPath:plistPath contents:(NSData *)myDic attributes:attr];
    return r;
}

-(Boolean)writeProtectedPlistFile:(NSString *)dataKey dataValue:(NSString *)dataValue{
    return YES;
}

-(Boolean)createFile:(NSString *)pathName{
    Boolean result = [filemanager createDirectoryAtPath:pathName withIntermediateDirectories:YES attributes:nil error:nil];
    return  result;
}



-(NSArray *)getChildFiles:(NSString *)path
{
//    NSArray *childFiles = [filemanager subpathsAtPath:path];
    NSError *error = nil;
    NSArray *childFiles = [filemanager contentsOfDirectoryAtPath:path error:&error];
    return childFiles;
}

-(BOOL)isNullFile:(NSString *)path
{
    if ([self isFileExisted:path]) {
        if([[self getChildFiles:path] count]>0){
            return  NO;
        }
        else
        {
            return  YES;
        }
    }
    return NO;
   
    
}

-(Boolean)saveStringInfoByTag:(NSString *)strValue tag:(NSString *)tag{
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    [myDic setObject:strValue forKey:tag];
    return [myDic writeToFile:[kDocmnentPath stringByAppendingPathComponent:appFileName] 
                   atomically:YES];
    
}

-(NSString *)getStringInfoByTag:(NSString *)tag{
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    NSString *info = [myDic objectForKey:tag];
    return info;
}



//-(NSDictionary *)getAllPlayersByRace:(NSString *)race{
//    
//    NSString *playerPath=[[NSBundle mainBundle] pathForResource:@"players" ofType:@"plist"];
//    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
//                                  initWithContentsOfFile:playerPath];
//    
//    
//}
//
//
//-(NSDictionary *)getAllPlayers{
//    NSString *playerPath=[[NSBundle mainBundle] pathForResource:@"players" ofType:@"plist"];
//    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
//                                  initWithContentsOfFile:playerPath];
//    return [[NSDictionary alloc]initWithDictionary:myDic];
//}

-(NSDictionary *)getAllResult{
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    return [[NSDictionary alloc]initWithDictionary:myDic];
}


-(NSArray *)getResultByTag:(NSString *)tag{
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    NSArray *resultArr = [myDic objectForKey:tag];
    return resultArr;
}

-(Boolean)saveResult:(NSArray *)resultArray key:(NSString *)key{
    
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    [myDic setObject:resultArray forKey:key];
    return [myDic writeToFile:[kDocmnentPath stringByAppendingPathComponent:appFileName] 
                   atomically:YES];
}

-(Boolean)deleteResult:(NSString *)key{
    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
    [myDic removeObjectForKey:key];
    return [myDic writeToFile:[kDocmnentPath stringByAppendingPathComponent:appFileName] 
                   atomically:YES];
}


////添加自定义评论
//-(Boolean)saveInfo:(NSString *)agreeinfo tag:(NSString *)tag{
//    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
//                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
//    NSMutableArray *tagarray = [myDic objectForKey:tag];
//    [tagarray addObject:agreeinfo];
//    return [myDic writeToFile:[kDocmnentPath stringByAppendingPathComponent:appFileName] 
//            atomically:YES];
//}
//
////删除自定义评论
//-(Boolean)deleteInfo:(NSString *)deletedInfo tag:(NSString *)tag{
//    NSMutableDictionary *myDic = [[NSMutableDictionary alloc]
//                                  initWithContentsOfFile:[kDocmnentPath stringByAppendingPathComponent:appFileName]];
//    NSMutableArray *tagarray = [myDic objectForKey:tag];
//    [tagarray removeObject:deletedInfo];
//    return [myDic writeToFile:[kDocmnentPath stringByAppendingPathComponent:appFileName] 
//                   atomically:YES];
//}




- (id)readPlist:(NSString *)filePath { 
    NSData *plistData;  
    NSString *error;  
    NSPropertyListFormat format;  
    id plist;  
    
//    NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    plistData = [NSData dataWithContentsOfFile:filePath];   
    
    plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];  
    if (!plist) {
    }  
    
    return plist;  
}  


@end
