//
//  MRViewController.m
//  Storage-Test
//
//  Created by biostime on 2018/8/31.
//  Copyright © 2018年 biostime. All rights reserved.
//

#import "MRViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "MRModel+CoreDataClass.h"
@interface MRViewController ()

@property (nonatomic ,strong)NSManagedObjectContext *localContext;
@property (nonatomic , assign) NSInteger count;

@end

@implementation MRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [MagicalRecord setupCoreDataStack];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MagicalRecord.db"];
    
    self.localContext    = [NSManagedObjectContext MR_context];
    
    self.count=[MRModel MR_findAll].count;
    
}

- (IBAction)addButtonClick:(id)sender {
    
    MRModel *model=[MRModel MR_createEntityInContext:self.localContext];
    model.id=self.count;
    model.name=[NSString stringWithFormat:@"name-%ld",self.count];
    
    if (self.count%2==0) {
        model.isShow=YES;
    }
    else{
        model.isShow=NO;
    }
    
    [self.localContext MR_saveToPersistentStoreAndWait];
}


- (IBAction)deleteButtonClick:(id)sender {
    
    
    NSLog(@"%ld",[MRModel MR_findAll].count);
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id=1"];
    
    
    BOOL success = [MRModel MR_deleteAllMatchingPredicate:predicate inContext:self.localContext];
    if (success) {
        NSLog(@"删除成功");
    }
    else{
        NSLog(@"删除失败");
    }
    [self.localContext MR_saveToPersistentStoreAndWait];

    
    
//    NSFetchRequest *request=[[NSFetchRequest alloc]init];
//    [request setPredicate:predicate];
//
//    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];
//
//    [request setEntity:entity];
//    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
//    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        BOOL success=[obj MR_deleteEntity];
//        if (success) {
//            NSLog(@"删除成功");
//        }
//        else{
//            NSLog(@"删除失败");
//        }
//    }];
//    //必须要加上这句话，不然没法删除成功
//    [self.localContext MR_saveToPersistentStoreAndWait];
}
- (IBAction)changeButtonClick:(id)sender {
    
//    NSArray *array=[MRModel MR_findByAttribute:@"id" withValue:[NSNumber numberWithInteger:1]];
//    [array enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.name=@"修改-name";
//    }];
    
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"id=1"];

    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setPredicate:predicate];

    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];

    [request setEntity:entity];
    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
        obj.name=@"修改-name";
//        BOOL success=[self.localContext save:nil];
//        if ( success) {
//            NSLog(@"修改成功");
//        }
//        else{
//            NSLog(@"修改失败");
//        }
    }];
    [self.localContext MR_saveToPersistentStoreAndWait];
    
}
- (IBAction)searchButtonClick:(id)sender {
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"isShow=1"];
//    NSFetchRequest *request=[[NSFetchRequest alloc]init];
//    [request setPredicate:predicate];
//
//    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MRModel" inManagedObjectContext:self.localContext];
//
//    [request setEntity:entity];
//    NSArray *arr=[self.localContext executeFetchRequest:request error:nil];
//    [arr enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
//    }];
    
    NSArray *array=[MRModel MR_findAll];
    [array enumerateObjectsUsingBlock:^(MRModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id: %lld , \nname: %@ ,\nisShow：%d", obj.id, obj.name,obj.isShow);
    }];
}

@end
