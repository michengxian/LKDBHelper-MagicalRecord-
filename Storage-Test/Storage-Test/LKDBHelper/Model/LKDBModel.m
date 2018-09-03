//
//  LKDBModel.m
//  Storage-Test
//
//  Created by biostime on 2018/8/31.
//  Copyright © 2018年 biostime. All rights reserved.
//

#import "LKDBModel.h"
#import "LKDBHelper.h"

@implementation LKDBModel

//+(LKDBHelper *)getUsingLKDBHelper
//{
//    static LKDBHelper *db;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString *sqlitePath = [LKDBUtils getDocumentPath];
//        NSString* dbpath = [sqlitePath stringByAppendingPathComponent:[NSString stringWithFormat:@"db/LKDB.db"]];
//        NSLog(@"路径：%@",dbpath);
//        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
//    });
//    return db;
//}

///**表名*/
//+(NSString *)getTableName
//{
//    return @"LKDB.db";
//}

/**主键名*/
+(NSString *)getPrimaryKey
{
    return @"model_id";
}

/**复合主键*/
//+(NSArray *)getPrimaryKeyUnionArray
//{
//
//}
@end
