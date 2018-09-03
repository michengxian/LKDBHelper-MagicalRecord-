# MVVM-test
MVVM-Test


## `LKDBHelper`和`MagicalRecord`的基本用法

>`LKDBHelper`是对`FMDB`的封装，可以在不写`sql`语句的情况下，使用`model`就可以全自动的进行数据表的创建，及数据的增、删、改、查。

***

>`MagicalRecord`是对`CoreData`的简单封装

引入方式`cocoachina`：

```
pod 'MagicalRecord', '~> 2.3.2'
pod 'LKDBHelper', '~> 2.5.1'
```

***

##  `LKDBHelper`初始化

> `LKDBModel`是我需要存储的类，`.h`文件：

```
@property (nonatomic , assign) NSInteger model_id;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , assign) BOOL isShow;

@property (nonatomic , strong) NSArray *dataArray;

//由于发现字典类型不能直接存储，所以转成NSString进行存储。
@property (nonatomic , strong) NSString *dataDictString;
```

`.m`文件，首先引入`#import "LKDBHelper.h"`头文件，一般情况，设置一个主键名就行：

```
///**设置表名，一般不写，默认表名为类名*/
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
```

***

## `LKDBHelper`增

```
    LKDBModel *model=[[LKDBModel alloc]init];
    model.model_id=self.count;
    model.name=[NSString stringWithFormat:@"name-%ld",self.count];
    if (self.count%2==0) {
        model.isShow=YES;
    }
    else{
        model.isShow=NO;
    }
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<self.count; i++) {
        [array addObject:[NSNumber numberWithInteger:i]];
    }
    model.dataArray=array;

    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    for (NSInteger i=0; i<self.count; i++) {
        [dict setObject:[NSString stringWithFormat:@"dict-%ld",self.count] forKey:[NSNumber numberWithInteger:i]];
    }
    model.dataDictString=[NSString stringWithFormat:@"%@",dict];
    [model saveToDB]
```

***

## `LKDBHelper`删

方式一（直接删除某个`model`）：

```
BOOL success=[self.helper deleteToDB:model];
```

方式二（根据条件删除）：

```
BOOL success=[self.helper deleteWithClass:[LKDBModel class] where:@{@"model_id":[NSNumber numberWithInteger:model.model_id]}];
```

***

## `LKDBHelper`改

```
model.name=[NSString stringWithFormat:@"changeName-%ld",self.count];
BOOL success=[model saveToDB];
```

***

## `LKDBHelper`查

```
[self.helper search:[LKDBModel class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray * _Nullable array) {
    NSLog(@"searchButtonClick:%@",array);
}];

```

***

## `coreData`的使用

[新建一个coreData](https://www.jianshu.com/p/d88586217736)

***

## `MagicalRecord`初始化，一般在`AppDelegate.m`的`didFinishLaunchingWithOptions`函数进行初始化

```
    [MagicalRecord setupCoreDataStack];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MagicalRecord.sqlite"];

    self.localContext    = [NSManagedObjectContext MR_context];
```

***

## `MagicalRecord`增

```
//初始化一个Model
    MRModel *model=[MRModel MR_createEntityInContext:self.localContext];
//对该Model进行赋值
    model.id=self.count;
    model.name=[NSString stringWithFormat:@"name-%ld",self.count];
    if (self.count%2==0) {
        model.isShow=YES;
    }
    else{
        model.isShow=NO;
    }

//这句话很重要。增删改查都要用这个方法来保存数据
[self.localContext MR_saveToPersistentStoreAndWait];
```

***

## `MagicalRecord`删

*  先查再删 **删除所有符合条件的数据**


```
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id=3"];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setPredicate:predicate];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];
    [request setEntity:entity];
    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL success=[obj MR_deleteEntity];
        if (success) {
            NSLog(@"删除成功");
        }
        else{
            NSLog(@"删除失败");
        }
    }];
    //必须要加上这句话，不然没法删除成功
    [self.localContext MR_saveToPersistentStoreAndWait];
```
*  直接删 **删除第一条符合条件的数据**


```
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id=1"];
    BOOL success = [MRModel MR_deleteAllMatchingPredicate:predicate inContext:self.localContext];
    if (success) {
        NSLog(@"删除成功");
    }
    else{
        NSLog(@"删除失败");
    }
    [self.localContext MR_saveToPersistentStoreAndWait];
```

***

## `MagicalRecord`改

*  用`MR_findByAttribute `查找并修改


```
NSArray *array=[MRModel MR_findByAttribute:@"id" withValue:[NSNumber numberWithInteger:1]];
    [array enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.name=@"修改-name";
    }];
    [self.localContext MR_saveToPersistentStoreAndWait];
```

*  用`NSFetchRequest `查找并修改


```
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setPredicate:predicate];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];
    [request setEntity:entity];
    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
        obj.name=@"修改-name";
    }];
    [self.localContext MR_saveToPersistentStoreAndWait];
```

***

## `MagicalRecord`查

*  查找所有


```
    NSArray *array=[MRModel MR_findAll];
    [array enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
    }];
```

*  根据条件查找


```
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"isShow=1"];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setPredicate:predicate];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];
    [request setEntity:entity];
    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
    }];
```

