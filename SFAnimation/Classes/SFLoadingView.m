//
//  SFLoadingView.m
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import "SFLoadingView.h"

@interface SFLoadingView ()
<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
@property (nonatomic, strong) CABasicAnimation *circleAnimation;
@property (nonatomic, strong) CABasicAnimation *loadingAnimation;
@property (nonatomic, assign) NSInteger animationPhase;

@end

@implementation SFLoadingView


#pragma mark - api
- (void)start {
    BOOL isCustom = [self customLoadingAnimation];
    if (isCustom) {
        [self.layer addSublayer:self.loadingLayer];
    }
}
- (void)pause {
    [self.loadingLayer removeFromSuperlayer];
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
    self.withCircle = YES;
    [self configCircleLayer];
    [self configLoadingLayer];
}
- (void)drawRect:(CGRect)rect {
    if (self.withCircle) {
        [self configCirclePath];
        [self.layer insertSublayer:self.circleLayer atIndex:0];
    }else{
        [self.circleLayer removeFromSuperlayer];
    }
    [self customLoadingPath];
}

#pragma mark - circleLayer
- (void)configCircleLayer {
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLineWidth = 5;
    self.circleLineColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
}
- (void)configCirclePath {
    self.circleLayer.frame = self.bounds;
    CGFloat radius = self.bounds.size.width/2.0f - self.circleLineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    self.circleLayer.path = path.CGPath;
}

#pragma mark - loadingLayer
- (void)configLoadingLayer {
    self.loadingLayer = [CAShapeLayer layer];
    self.loadingLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.loadingLayer.lineCap = kCALineCapRound;
    self.loadingLineWidth = 5;
    self.loadingLineColor = [UIColor orangeColor];
}


#pragma mark - setter
- (void)setCircleLineWidth:(CGFloat)circleLineWidth {
    _circleLineWidth = circleLineWidth;
    self.circleLayer.lineWidth = circleLineWidth;
}
- (void)setCircleLineColor:(UIColor *)circleLineColor {
    _circleLineColor = circleLineColor;
    self.circleLayer.strokeColor = circleLineColor.CGColor;
}
- (void)setLoadingLineWidth:(CGFloat)loadingLineWidth {
    _loadingLineWidth = loadingLineWidth;
    self.loadingLayer.lineWidth = loadingLineWidth;
}
- (void)setLoadingLineColor:(UIColor *)loadingLineColor {
    _loadingLineColor = loadingLineColor;
    self.loadingLayer.strokeColor = loadingLineColor.CGColor;
}


#pragma mark - 在子类中实现
- (void)customLoadingPath {
    
}
- (BOOL)customLoadingAnimation {
    return NO;
}



@end


#pragma mark - SFLoadingViewA
@interface SFLoadingViewA ()

@end

@implementation SFLoadingViewA

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self defaultSetting];
    }
    return self;
}
- (void)defaultSetting {
    self.startAngle = -M_PI_2;
    self.endAngle = -M_PI_4;
    self.timingFunc = kCAMediaTimingFunctionLinear;
    self.duration = 2;
}

#pragma mark - custom
- (void)customLoadingPath {
    self.loadingLayer.frame = self.bounds;
    CGFloat radius = self.loadingLayer.bounds.size.width/2.0f - self.loadingLineWidth/2.0f;
    CGFloat centerX = self.loadingLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.loadingLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.loadingLayer.path = path.CGPath;
}

- (BOOL)customLoadingAnimation {
    if (self.withGrow) {
        [self withGrowAnimation];
    }else{
        [self withoutGrowAnimation];
    }
    return YES;
}
- (void)withGrowAnimation {
    CGFloat deta = self.endAngle - self.startAngle;
    if (deta < 0) {
        deta += 2*M_PI;
    }
    CGFloat r = deta/(2*M_PI+deta);
    
    // grow
    CABasicAnimation *anim_grow = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim_grow.fromValue = [NSNumber numberWithFloat:0.0];
    anim_grow.toValue = [NSNumber numberWithFloat:1.0];
    anim_grow.removedOnCompletion = NO;
    anim_grow.fillMode = kCAFillModeForwards;
    anim_grow.beginTime = 0;
    anim_grow.duration = self.duration * r;
    anim_grow.repeatCount = 1;
    [self.loadingLayer addAnimation:anim_grow forKey:@"anim_grow"];
    
    // loading
    CABasicAnimation *anim_loading = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_loading.fromValue = [NSNumber numberWithFloat:self.startAngle];
    anim_loading.toValue = [NSNumber numberWithFloat:self.startAngle+2*M_PI];
    anim_loading.beginTime = anim_grow.beginTime + anim_grow.duration;
    anim_loading.duration = self.duration - anim_grow.duration;
    anim_loading.repeatCount = MAXFLOAT;
    [self.loadingLayer addAnimation:anim_loading forKey:@"anim_loading"];
}
- (void)withoutGrowAnimation {
    CABasicAnimation *anim_loading = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_loading.fromValue = [NSNumber numberWithFloat:self.startAngle];
    anim_loading.toValue = [NSNumber numberWithFloat:self.startAngle+2*M_PI];
    anim_loading.beginTime = 0;
    anim_loading.duration = self.duration;
    anim_loading.repeatCount = MAXFLOAT;
    [self.loadingLayer addAnimation:anim_loading forKey:@"anim_loading"];
}


@end


#pragma mark - SFLoadingViewB
@interface SFLoadingViewB ()

@end

@implementation SFLoadingViewB

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self defaultSetting];
    }
    return self;
}
- (void)defaultSetting {
    
}

#pragma mark - custom
- (void)customLoadingPath {
    
}

- (BOOL)customLoadingAnimation {
    return NO;
}

#pragma mark - setter



@end
