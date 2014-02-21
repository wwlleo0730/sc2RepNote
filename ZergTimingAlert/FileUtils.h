//
//  FileUtils.h
//
//  Created by wwl on 12-1-11.
//  Copyright 2012年 esse. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtils : NSObject {
    NSFileManager *filemanager;
}

-(Boolean)isFileExisted:(NSString *)pathName;       //判断路径是否存在
-(Boolean)createFile:(NSString *)pathName;          //根据路径创建文件或文件夹
-(NSArray *)getChildFiles:(NSString *)path;         //获取path目录下的所有文件 
-(BOOL)isNullFile:(NSString *)path;

-(Boolean)createProtectedPlistFile:(NSString *)plistPath;
-(Boolean)writeProtectedPlistFile:(NSString *)dataKey dataValue:(NSString *)dataValue;


-(NSString *)getStringInfoByTag:(NSString *)tag;
-(Boolean)saveStringInfoByTag:(NSString *)strValue tag:(NSString *)tag;
-(NSArray *)getResultByTag:(NSString *)tag;
-(Boolean)saveResult:(NSArray *)resultArray key:(NSString *)key;
-(Boolean)deleteResult:(NSString *)key;
-(NSDictionary *)getAllResult;



@end
