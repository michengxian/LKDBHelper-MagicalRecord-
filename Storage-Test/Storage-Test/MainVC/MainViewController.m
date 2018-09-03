//
//  MainViewController.m
//  Storage-Test
//
//  Created by biostime on 2018/8/30.
//  Copyright © 2018年 biostime. All rights reserved.
//

#import "MainViewController.h"
#import "LKDBViewController.h"
#import "MRViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *LKDBHButton;
@property (weak, nonatomic) IBOutlet UIButton *MRButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)LKDBHButtonClick:(id)sender {
    LKDBViewController *MRVC=[[LKDBViewController alloc]init];
    [self.navigationController pushViewController:MRVC animated:YES];
}

- (IBAction)MRButtonClick:(id)sender {
    MRViewController *MRVC=[[MRViewController alloc]init];
    [self.navigationController pushViewController:MRVC animated:YES];
}


@end
