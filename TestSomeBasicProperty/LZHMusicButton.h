//
//  LZHMusicButton.h
//  MyHeart
//
//  Created by LZH on 15/12/14.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LZHMusicButton : UIButton

@property (nonatomic, assign) CGFloat time;

- (void)buttonPressedWithTime: (CGFloat)time;
- (void)stop;

@end
