//
//  SFLoadingView.m
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import "SFLoadingView.h"

@interface SFLoadingView ()
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) CGFloat incrementAngle; // 增量

// 有多段动画时会用到
@property (nonatomic, assign) NSInteger phase;

@end

@implementation SFLoadingView


#pragma mark - api
- (void)start {
    self.link.paused = NO;
}
- (void)pause {
    self.link.paused = YES;
    self.progress = 0;
}


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    self.initAngle = -M_PI_2;
    self.rangePercent = 0.7;
    self.incrementAngle = M_PI_4;
    
    self.animationLayer = [CAShapeLayer layer];
    self.animationLayer.fillColor = [UIColor clearColor].CGColor;
    self.animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.animationLayer];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkEvent)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.link.paused = YES;
    
    self.lineWidth = 5;
    self.lineColor = [UIColor orangeColor];
}
- (void)drawRect:(CGRect)rect {
    self.animationLayer.bounds = CGRectMake(0, 0, self.bounds.size.width/2.0f, self.bounds.size.width/2.0f);
    self.animationLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
}


#pragma mark - setter
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.animationLayer.strokeColor = lineColor.CGColor;
}
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.animationLayer.lineWidth = lineWidth;
}


#pragma mark - func
- (void)linkEvent {
    self.progress += self.speed;
    if (self.progress >= 1) {
        self.progress = 0;
    }
    [self updateAnimationLayer];
}

- (void)updateAnimationLayer {
    [self styleC];
}

- (void)styleA {
    self.startAngle = self.initAngle + self.progress * (M_PI*2);
    self.endAngle = self.startAngle + self.rangePercent * (M_PI*2);
    CGFloat radius = self.animationLayer.bounds.size.width/2.0f - self.lineWidth/2.0f;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
}
- (void)styleB {
    if (self.phase == 0) {
        self.startAngle = self.initAngle;
        self.endAngle = self.startAngle + self.progress * M_PI * 2;
        if (self.progress >= self.rangePercent) {
            self.phase = 1;
            self.progress = 0;
        }
    }else{
        self.startAngle = self.initAngle + self.progress * (M_PI*2);
        self.endAngle = self.startAngle + self.rangePercent * (M_PI*2);
    }
    
    CGFloat radius = self.animationLayer.bounds.size.width/2.0f - self.lineWidth/2.0f;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
}
- (void)styleC {
    if (self.phase == 0) {
        self.startAngle = self.initAngle;
        self.endAngle = self.startAngle + self.progress * M_PI * 2;
        if (self.progress >= self.rangePercent) {
            self.phase = 1;
            self.speed /= 2.0f; // 速度放慢一倍
        }
    }else{
        self.startAngle = self.initAngle;
        self.endAngle = self.startAngle + self.progress * M_PI * 2;
    }
    CGFloat radius = self.animationLayer.bounds.size.width/2.0f - self.lineWidth/2.0f;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
}


@end
