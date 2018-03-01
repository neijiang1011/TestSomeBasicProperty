//
//  LZHCircularProgressView.h
//  MyHeart
//
//  Created by LZH on 15/12/14.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZHCircularProgressView : UIControl

@property (nonatomic) float progress;

// On iOS 7, progressTintColor sets and gets the tintColor property, and therefore defaults to the value of tintColor
// On iOS 6, defaults to [UIColor blackColor]

@property (nonatomic, strong) UIColor *progressTintColor;

//启动 时间单位为秒, 传入参数0表示无限期执行，直到手动停止
- (void)startWithTime: (CGFloat)seconds;

//停止
- (void)stop;

- (instancetype)initWithFrame:(CGRect)frame;

@end
