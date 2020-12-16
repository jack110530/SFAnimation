//
//  SFCircleLoadingView.m
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import "SFCircleLoadingView.h"

@interface SFCircleLoadingView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CABasicAnimation *circleAnimation;

@end

@implementation SFCircleLoadingView


#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self config];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.withCircle) {
        [self configCirclePath];
        [self.layer insertSublayer:self.circleLayer atIndex:0];
    }else{
        [self.circleLayer removeFromSuperlayer];
    }
    [super drawRect:rect];
}

#pragma mark - config
- (void)config {
    self.withCircle = YES;
    self.startAngle = -M_PI_2;
    self.endAngle = -M_PI_4;
    self.timingFunc = kCAMediaTimingFunctionLinear;
    self.duration = 2;
    [self configCircleLayer];
    [self configLoadingLayer];
}
- (void)configCircleLayer {
    self.circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLineWidth = 5;
    self.circleLineColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
}
- (void)configLoadingLayer {
    self.loadingLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.loadingLayer.lineCap = kCALineCapRound;
    self.loadingLineWidth = 5;
    self.loadingLineColor = [UIColor orangeColor];
}
- (void)configCirclePath {
    self.circleLayer.frame = self.bounds;
    CGFloat radius = self.bounds.size.width/2.0f - self.circleLineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    self.circleLayer.path = path.CGPath;
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
    switch (self.animation) {
        case SFCircleLoadingAnimationDefault:
        {
            [self animationDefault];
        }
            break;
            
        case SFCircleLoadingAnimationGrowFirst:
        {
            [self animationGrowFirst];
        }
            break;
            
        case SFCircleLoadingAnimationGrowSync:
        {
            [self animationGrowSync];
        }
            break;
            
        default:
            break;
    }
    
    return YES;
}

#pragma mark - SFCircleLoadingAnimation
// MARK: SFCircleLoadingAnimationDefault
- (void)animationDefault {
    CABasicAnimation *anim_loading = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_loading.fromValue = [NSNumber numberWithFloat:0];
    anim_loading.toValue = [NSNumber numberWithFloat:2*M_PI];
    anim_loading.beginTime = CACurrentMediaTime();
    anim_loading.duration = self.duration;
    anim_loading.repeatCount = MAXFLOAT;
    [self.loadingLayer addAnimation:anim_loading forKey:@"anim_loading"];
}
// MARK: SFCircleLoadingAnimationGrowFirst
- (void)animationGrowFirst {
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
    anim_grow.beginTime = CACurrentMediaTime() + 0;
    anim_grow.duration = self.duration * r;
    anim_grow.repeatCount = 1;
    [self.loadingLayer addAnimation:anim_grow forKey:@"anim_grow"];
    
    // loading
    CABasicAnimation *anim_loading = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_loading.fromValue = [NSNumber numberWithFloat:0];
    anim_loading.toValue = [NSNumber numberWithFloat:2*M_PI];
    anim_loading.beginTime = anim_grow.beginTime + anim_grow.duration;
    anim_loading.duration = self.duration - anim_grow.duration;
    anim_loading.repeatCount = MAXFLOAT;
    [self.loadingLayer addAnimation:anim_loading forKey:@"anim_loading"];
}
// MARK: SFCircleLoadingAnimationGrowSync
- (void)animationGrowSync {
    // grow
    CABasicAnimation *anim_grow = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim_grow.fromValue = [NSNumber numberWithFloat:0.0];
    anim_grow.toValue = [NSNumber numberWithFloat:1.0];
    anim_grow.removedOnCompletion = NO;
    anim_grow.fillMode = kCAFillModeForwards;
    anim_grow.beginTime = 0;
    anim_grow.duration = self.duration;
    anim_grow.repeatCount = 1;
    [self.loadingLayer addAnimation:anim_grow forKey:@"anim_grow"];
    
    // loading
    CABasicAnimation *anim_loading = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_loading.fromValue = [NSNumber numberWithFloat:0];
    anim_loading.toValue = [NSNumber numberWithFloat:2*M_PI];
    anim_loading.beginTime = 0;
    anim_loading.duration = self.duration;
    anim_loading.repeatCount = MAXFLOAT;
    [self.loadingLayer addAnimation:anim_loading forKey:@"anim_loading"];
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


#pragma mark - getter
- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
    }
    return _circleLayer;
}


@end

