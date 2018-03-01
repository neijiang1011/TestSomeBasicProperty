//
//  SecondViewController.m
//  TestSomeBasicProperty
//
//  Created by yetao ye on 2018/2/26.
//  Copyright © 2018年 com.changhong. All rights reserved.
//

#import "SecondViewController.h"
#import "LZHMusicButton.h"
#import "ThirdViewController.h"

@interface SecondViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self modifyBackBtnStyle];
    [self addCustomView];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)modifyBackBtnStyle {
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 12, 21);
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"黑色返回"] forState: UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -40;
//    self.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
    
    //创建返回按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0,  12, 21);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];;
    //创建UIBarButtonSystemItemFixedSpace
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //将宽度设为负值
    spaceItem.width = -30;
    //将两个BarButtonItem都返回给NavigationItem
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftBarBtn];
    
    
    self.title = @"second  Page";
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)clickLeft:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addCustomView {
//    LZHMusicButton *btn = [[LZHMusicButton alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:btn];
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.frame];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn {
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    thirdVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:thirdVC animated:YES];
}



-(void)dealloc {
    NSLog(@"second vc dealloc");
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
