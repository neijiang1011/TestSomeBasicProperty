//
//  LZHMusicButton.m
//  MyHeart
//
//  Created by LZH on 15/12/14.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "LZHMusicButton.h"

#import "LZHCircularProgressView.h"

@interface LZHMusicButton (){

    BOOL _isStared;
}

@property (strong, nonatomic) LZHCircularProgressView *evcircular;

@end

@implementation LZHMusicButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    if (self.evcircular == nil) {
        
        CGRect rect = self.bounds;
        
        self.evcircular = [[LZHCircularProgressView alloc] initWithFrame: CGRectMake((rect.size.width - 28) / 2.0, (rect.size.height - 28) / 2.0, 28, 28)];
        self.evcircular.userInteractionEnabled = NO;
        self.evcircular.progressTintColor = [UIColor grayColor];
        self.evcircular.tintColor = [UIColor grayColor];
        
        [self addSubview: self.evcircular];
        
        _isStared = NO;
        //[self addTarget:self action: @selector(handleButton:) forControlEvents: UIControlEventTouchUpInside];
    }

}

//- (void) handleButton: (id)sender{
//    
//    [self.evcircular startWithTime: 10];
//}

- (void)buttonPressedWithTime: (CGFloat)time{
    
    //NSLog(@"lllllll: %@", self.evcircular);
    
    _isStared = YES;
    [self.evcircular startWithTime: time];
    
//    if (_isStared) {
//        _isStared = NO;
//        
//        [self stop];
//    }else{
//    
//        _isStared = YES;
//        [self.evcircular startWithTime: time];
//    }
    
}

- (void)stop{
    
    NSLog(@"stopstopstop");

    _isStared = NO;
    [self.evcircular stop];
}

-(void)dealloc {
    NSLog(@"lzh dealloc");
}

@end
