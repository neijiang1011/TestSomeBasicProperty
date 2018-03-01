//
//  ViewController.m
//  TestSomeBasicProperty
//
//  Created by yetao ye on 2018/2/26.
//  Copyright © 2018年 com.changhong. All rights reserved.
//

#import "ViewController.h"
#import <XHToast.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.navigationController setNavigationBarHidden:YES];
    //[[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"first";
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    [XHToast showCenterWithText:@"haha"];
}

-(void)viewDidAppear:(BOOL)animated {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
