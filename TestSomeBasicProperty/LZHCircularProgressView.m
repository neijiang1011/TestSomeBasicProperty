//
//  LZHCircularProgressView.m
//  MyHeart
//
//  Created by LZH on 15/12/14.
//  Copyright © 2015年 LZH. All rights reserved.
//

#import "LZHCircularProgressView.h"


#define DEGREES_TO_RADIANS(x) (x) / 180.0 * M_PI
#define RADIANS_TO_DEGREES(x) (x) / M_PI * 180.0

#define TIME_INTEVAL 0.02

@interface LZHCircularProgressViewBackgroundLayer : CALayer

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) BOOL started;

@end

@implementation LZHCircularProgressViewBackgroundLayer

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    
    return self;
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx{
    
    CGContextSetFillColorWithColor(ctx, self.tintColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.tintColor.CGColor);
    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 1, 1));
    
    if (self.started) {
        CGContextFillRect(ctx, CGRectMake(CGRectGetMidX(self.bounds) - 4, CGRectGetMidY(self.bounds) - 4, 8, 8));
    }else{
        
        CGPoint sPoints[3];//坐标点
        sPoints[0] =CGPointMake(CGRectGetMidX(self.bounds) - 3, CGRectGetMidY(self.bounds) - 7);//坐标1
        sPoints[1] =CGPointMake(CGRectGetMidX(self.bounds) + 6, CGRectGetMidY(self.bounds));//坐标2
        sPoints[2] =CGPointMake(CGRectGetMidX(self.bounds) - 3, CGRectGetMidY(self.bounds) + 7);//坐标3
        CGContextAddLines(ctx, sPoints, 3);//添加线
        CGContextClosePath(ctx);//封起来
        CGContextFillPath(ctx);
    }
}

@end

@interface LZHCircularProgressView (){
    
    UIColor *_progressTintColor;
    NSTimer *_timer;
    
    double _disInteval;
    BOOL _isStarted;
}

@property (nonatomic, strong) LZHCircularProgressViewBackgroundLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end



@implementation LZHCircularProgressView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 28, 28)];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    
    self = [super initWithCoder:coder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit{
    
    _progressTintColor = [UIColor grayColor];
    
    LZHCircularProgressViewBackgroundLayer *backgroundLayer = [[LZHCircularProgressViewBackgroundLayer alloc] init];
    
    backgroundLayer.frame = self.bounds;
    backgroundLayer.tintColor = self.progressTintColor;
    [self.layer addSublayer:backgroundLayer];
    self.backgroundLayer = backgroundLayer;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = self.progressTintColor.CGColor;
    
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
    
    backgroundLayer.tintColor = [UIColor grayColor];
    shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
    _isStarted = NO;
}

- (void)setProgress:(float)progress{
    
    _progress = progress;
    
    if (progress < 0) {
        return;
    }
    
    if (progress < 1.0) {
        
        if (self.backgroundLayer.started == NO) {
            
            self.backgroundLayer.started = YES;
            [self.backgroundLayer setNeedsDisplay];
        }
        
    }else{
        
        if (self.backgroundLayer.started == YES) {
            self.backgroundLayer.started = NO;
            [self.backgroundLayer setNeedsDisplay];
        }
        
        progress = 0;
    }
    
    [self drawCircle: progress];
    
}

- (void)drawCircle: (CGFloat)progress{
    
    self.shapeLayer.lineWidth = 3;
    self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                          radius:self.bounds.size.width/2 - 2
                                                      startAngle:3*M_PI_2
                                                        endAngle:3*M_PI_2 + 2*M_PI
                                                       clockwise:YES].CGPath;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.shapeLayer.strokeEnd = progress;
    [CATransaction commit];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    if ([self respondsToSelector:@selector(setTintColor:)]) {
        self.tintColor = progressTintColor;
    } else {
        _progressTintColor = progressTintColor;
        [self tintColorDidChange];
    }
}

- (UIColor *)progressTintColor
{
    if ([self respondsToSelector:@selector(tintColor)]) {
        return self.tintColor;
    } else {
        return _progressTintColor;
    }
}

//启动 时间单位为秒, 传入参数0表示无限期执行，直到手动停止
- (void)startWithTime: (CGFloat)seconds{
    
    //NSLog(@"||||||_isStarted: %@", [NSNumber numberWithBool: _isStarted]);
    
    if (_isStarted) {
        _isStarted = NO;
        
        [self stop];
    }else{
        
        _isStarted = YES;
        
        [self doStartWithTime: seconds];
    }
}

- (void)doStartWithTime: (CGFloat)seconds{
    
    if (seconds <= 0) {
        return;
    }else{
        
        _disInteval = TIME_INTEVAL / seconds;
        
        NSLog(@"_disInteval: %f  seconds: %f, %f", _disInteval, seconds, TIME_INTEVAL * seconds);
        
        _timer = [NSTimer scheduledTimerWithTimeInterval: TIME_INTEVAL target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
        
    }
}

//停止
- (void)stop{
    
    [_timer invalidate];
    _timer = nil;
    self.progress = 0.0;
    self.backgroundLayer.started = NO;
    [self.backgroundLayer setNeedsDisplay];
    
    [self drawCircle: 0];
    
    _isStarted = NO;
}

- (void)updateProgress:(NSTimer *)timer{
    
    if (self.progress >= 1.0) {
        
        [self stop];
    } else {
        self.tintColor = [UIColor grayColor];
        
        [self setProgress:self.progress + _disInteval];
    }
}



@end
