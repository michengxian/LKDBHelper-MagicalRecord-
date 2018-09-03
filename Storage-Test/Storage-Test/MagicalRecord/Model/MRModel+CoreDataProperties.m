//
//  MRModel+CoreDataProperties.m
//  
//
//  Created by biostime on 2018/9/3.
//
//

#import "MRModel+CoreDataProperties.h"

@implementation MRModel (CoreDataProperties)

+ (NSFetchRequest<MRModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MRModel"];
}

@dynamic id;
@dynamic name;
@dynamic isShow;

@end
