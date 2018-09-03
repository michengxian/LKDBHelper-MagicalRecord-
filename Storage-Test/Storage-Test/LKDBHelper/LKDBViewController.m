//
//  LKDBViewController.m
//  Storage-Test
//
//  Created by biostime on 2018/8/30.
//  Copyright © 2018年 biostime. All rights reserved.
//

#import "LKDBViewController.h"
#import "LKDBModel.h"
#import "LKDBHelper.h"

@interface LKDBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;


@property (nonatomic , strong) LKDBHelper *helper;
@property (nonatomic , assign) NSInteger count;

@end

@implementation LKDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.helper=[LKDBHelper getUsingLKDBHelper];
    self.count=1;
    
}
- (IBAction)addButtonClick:(id)sender {
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
    
    BOOL success=[model saveToDB];
    if (success) {
        NSLog(@"添加数据成功：\nmodel_id:%ld \nname:%@ \nisShow:%d \ndataArray:%@ \ndataDict:%@",model.model_id,model.name,model.isShow,model.dataArray,model.dataDictString);
    }
    else{
        NSLog(@"添加数据失败");
    }
    self.count++;
}
- (IBAction)deleteButtonClick:(id)sender {
    [self.helper search:[LKDBModel class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray * _Nullable array) {
        LKDBModel *model=[array lastObject];
        BOOL success=[self.helper deleteToDB:model];
//        BOOL success=[self.helper deleteWithClass:[LKDBModel class] where:@{@"model_id":[NSNumber numberWithInteger:model.model_id]}];
        if (success) {
            NSLog(@"删除数据成功：\nmodel_id:%ld \nname:%@ \nisShow:%d \ndataArray:%@ \ndataDict:%@",model.model_id,model.name,model.isShow,model.dataArray,model.dataDictString);
        }
        else{
            NSLog(@"删除数据失败");
        }
    }];
}
- (IBAction)changeButtonClick:(id)sender {
    [self.helper search:[LKDBModel class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray * _Nullable array) {
        LKDBModel *model=[array lastObject];
        model.name=[NSString stringWithFormat:@"changeName-%ld",self.count];
        BOOL success=[model saveToDB];
        if (success) {
            NSLog(@"改变数据成功：\nmodel_id:%ld \nname:%@ \nisShow:%d \ndataArray:%@ \ndataDict:%@",model.model_id,model.name,model.isShow,model.dataArray,model.dataDictString);
        }
        else{
            NSLog(@"改变数据失败");
        }
    }];
}
- (IBAction)searchButtonClick:(id)sender {
    [self.helper search:[LKDBModel class] where:nil orderBy:nil offset:0 count:0 callback:^(NSMutableArray * _Nullable array) {
        NSLog(@"searchButtonClick:%@",array);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
