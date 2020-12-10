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

- (void)drawRect:(CGRect)rect {
    self.animationLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
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
    self.animationLayer = [CAShapeLayer layer];
    self.animationLayer.fillColor = [UIColor clearColor].CGColor;
    self.animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.animationLayer];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkEvent)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.link.paused = YES;
    
    self.radius = 60;
    self.lineWidth = 5;
    self.lineColor = [UIColor orangeColor];
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
- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    self.animationLayer.bounds = CGRectMake(0, 0, radius, radius);
}

#pragma mark - func
- (void)linkEvent {
    self.progress += [self speed];
    if (self.progress >= 1) {
        self.progress = 0;
    }
    [self updateAnimationLayer];
}
- (CGFloat)speed {
    if (self.endAngle > M_PI) {
        return 0.2/60.0f;
    }
    return 1.1/60.0f;
}
- (void)updateAnimationLayer {
    self.startAngle = -M_PI_2;
    self.endAngle = -M_PI_2 +self.progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - self.progress)/0.25;
        self.startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = self.animationLayer.bounds.size.width/2.0f - self.lineWidth/2.0f;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
}




@end
