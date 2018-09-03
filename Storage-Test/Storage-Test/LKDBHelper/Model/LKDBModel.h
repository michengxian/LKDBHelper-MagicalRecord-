//
//  LKDBModel.h
//  Storage-Test
//
//  Created by biostime on 2018/8/31.
//  Copyright © 2018年 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDBModel : NSObject

@property (nonatomic , assign) NSInteger model_id;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , assign) BOOL isShow;

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , strong) NSString *dataDictString;

@end
