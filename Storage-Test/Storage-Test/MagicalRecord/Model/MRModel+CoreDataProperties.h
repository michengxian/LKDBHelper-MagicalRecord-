//
//  MRModel+CoreDataProperties.h
//  
//
//  Created by biostime on 2018/9/3.
//
//

#import "MRModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MRModel (CoreDataProperties)

+ (NSFetchRequest<MRModel *> *)fetchRequest;

@property (nonatomic) int64_t id;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL isShow;

@end

NS_ASSUME_NONNULL_END
