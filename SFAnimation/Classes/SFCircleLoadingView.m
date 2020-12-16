//
//  SFCircleLoadingView.m
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import "SFCircleLoadingView.h"
#define SF_Default_Angel (-1)
#define SF_Default_During (-1)
#define SF_Default_TimingFunc (-1)

@interface SFCircleLoadingView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;

// 默认值
@property (nonatomic, assign) CGFloat startAngleDefault;
@property (nonatomic, assign) CGFloat endAngleDefault;
@property (nonatomic, assign) CFTimeInterval durationDefault;
@property (nonatomic, assign) SFCircleLoadingTimingFunc timingFuncDefault;

@end

IB_DESIGNABLE
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
    _startAngle = SF_Default_Angel;
    _endAngle = SF_Default_Angel;
    _duration = SF_Default_During;
    _timingFunc = SF_Default_TimingFunc;
    self.animation = SFCircleLoadingAnimationRotate;
    [self configCircleLayer];
    [self configAnimationLayer];
}
- (void)configCircleLayer {
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLineWidth = 5;
    self.circleLineColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
}
- (void)configAnimationLayer {
    self.animationLayer.lineCap = kCALineCapRound;
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
- (void)customPath {
    self.animationLayer.frame = self.bounds;
    CGFloat radius = self.animationLayer.bounds.size.width/2.0f - self.loadingLineWidth/2.0f;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
}

- (void)customAnimation {
    switch (self.animation) {
        case SFCircleLoadingAnimationRotate:
        {
            [self animationRotate];
        }
            break;
            
        case SFCircleLoadingAnimationGrowThenRotate:
        {
            [self animationGrowThenRotate];
        }
            break;
            
        case SFCircleLoadingAnimationGrowSyncRotate:
        {
            [self animationGrowSyncRotate];
        }
            break;
            
        case SFCircleLoadingAnimationGrowThenReduce:
        {
            [self animationGrowAndReduce];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SFCircleLoadingAnimation
// MARK: SFCircleLoadingAnimationRotate
- (void)animationRotate {
    CABasicAnimation *anim_rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim_rotate.fromValue = [NSNumber numberWithFloat:0];
    anim_rotate.toValue = [NSNumber numberWithFloat:2*M_PI];
    anim_rotate.beginTime = CACurrentMediaTime();
    anim_rotate.duration = self.duration;
    anim_rotate.repeatCount = MAXFLOAT;
    anim_rotate.timingFunction = [self getUsefulTimingFunc];
    [self.animationLayer addAnimation:anim_rotate forKey:@"anim_rotate"];
}
// MARK: SFCircleLoadingAnimationGrowThenRotate
- (void)animationGrowThenRotate {
    CGFloat deta = self.endAngle - self.startAngle;
    if (deta < 0) {
        deta += 2*M_PI;
    }
    CGFloat r = deta/(2*M_PI+deta);
    
    // grow
    CABasicAnimation *anim_grow;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.beginTime = CACurrentMediaTime() + 0;
        anim.duration = self.duration * r;
        anim.repeatCount = 1;
        anim.timingFunction = [self getUsefulTimingFunc];
        anim_grow = anim;
        [self.animationLayer addAnimation:anim forKey:@"anim_grow"];
    }
    
    // rotate
    CABasicAnimation *anim_rotate;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        anim.fromValue = [NSNumber numberWithFloat:0];
        anim.toValue = [NSNumber numberWithFloat:2*M_PI];
        anim.beginTime = anim_grow.beginTime + anim_grow.duration;
        anim.duration = self.duration - anim_grow.duration;
        anim.repeatCount = MAXFLOAT;
        anim_rotate = anim;
        [self.animationLayer addAnimation:anim forKey:@"anim_rotate"];
    }
}
// MARK: SFCircleLoadingAnimationGrowSyncRotate
- (void)animationGrowSyncRotate {
    // grow
    CABasicAnimation *anim_grow;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.beginTime = 0;
        anim.duration = self.duration;
        anim.repeatCount = 1;
        anim.timingFunction = [self getUsefulTimingFunc];
        anim_grow = anim;
        [self.animationLayer addAnimation:anim forKey:@"anim_grow"];
    }
    
    // rotate
    CABasicAnimation *anim_rotate;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        anim.fromValue = [NSNumber numberWithFloat:0];
        anim.toValue = [NSNumber numberWithFloat:2*M_PI];
        anim.beginTime = 0;
        anim.duration = self.duration;
        anim.repeatCount = MAXFLOAT;
        anim_rotate = anim;
        [self.animationLayer addAnimation:anim forKey:@"anim_rotate"];
    }
}
// MARK: SFCircleLoadingAnimationGrowThenReduce
- (void)animationGrowAndReduce {
    // grow
    CABasicAnimation *anim_grow;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = self.duration/3;
        anim.beginTime = 0;
        anim.repeatCount = 1;
        anim.timingFunction = [self getUsefulTimingFunc];
        anim_grow = anim;
    }

    // reduce
    CABasicAnimation *anim_reduce;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.duration = self.duration - anim_grow.duration;
        anim.beginTime = anim_grow.beginTime + anim_grow.duration;
        anim.repeatCount = 1;
        anim.timingFunction = [self getUsefulTimingFunc];
        anim_reduce = anim;
    }
    
    // rotate
    CABasicAnimation *anim_rotate;
    {
        CGFloat angel = self.endAngle - self.startAngle;
        if (angel < 0) {
            angel += 2*M_PI;
        }
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        anim.fromValue = [NSNumber numberWithFloat:0];
        anim.toValue = [NSNumber numberWithFloat:2*M_PI-angel];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.beginTime = anim_reduce.beginTime;
        anim.duration = anim_reduce.duration;
        anim.repeatCount = 1;
        anim_rotate = anim;
    }

    // group
    CAAnimationGroup *anim_group;
    {
        CAAnimationGroup *anim = [CAAnimationGroup animation];
        anim.repeatCount = MAXFLOAT;
        anim.duration = self.duration;
        anim.animations = @[anim_grow, anim_reduce, anim_rotate];
        anim_group = anim;
        [self.animationLayer addAnimation:anim forKey:@"anim_group"];
    }
}

#pragma mark - func
- (CAMediaTimingFunction *)getUsefulTimingFunc{
    CAMediaTimingFunctionName name;
    switch (self.timingFunc) {
        case SFCircleLoadingTimingFuncLinear:
        {
            name = kCAMediaTimingFunctionLinear;
        }
            break;
            
        case SFCircleLoadingTimingFuncEaseIn:
        {
            name = kCAMediaTimingFunctionEaseIn;
        }
            break;
            
        case SFCircleLoadingTimingFuncEaseOut:
        {
            name = kCAMediaTimingFunctionEaseOut;
        }
            break;
            
        case SFCircleLoadingTimingFuncEaseInEaseOut:
        {
            name = kCAMediaTimingFunctionEaseInEaseOut;
        }
            break;
            
        default:
        {
            name = kCAMediaTimingFunctionLinear;
        }
            break;
    }
    return [CAMediaTimingFunction functionWithName:name];
}


#pragma mark - setter
- (void)setAnimation:(SFCircleLoadingAnimation)animation {
    _animation = animation;
    switch (animation) {
        case SFCircleLoadingAnimationRotate:
        {
            self.withCircle = YES;
            self.startAngleDefault = -M_PI_2;
            self.endAngleDefault = -M_PI_4;
            self.timingFuncDefault = SFCircleLoadingTimingFuncLinear;
            self.durationDefault = 2;
        }
            break;
            
        case SFCircleLoadingAnimationGrowThenRotate:
        {
            self.withCircle = YES;
            self.startAngleDefault = -M_PI_2;
            self.endAngleDefault = M_PI;
            self.timingFuncDefault = SFCircleLoadingTimingFuncLinear;
            self.durationDefault = 2;
        }
            break;
            
        case SFCircleLoadingAnimationGrowSyncRotate:
        {
            self.withCircle = YES;
            self.startAngleDefault = -M_PI_2;
            self.endAngleDefault = M_PI;
            self.timingFuncDefault = SFCircleLoadingTimingFuncLinear;
            self.durationDefault = 2;
        }
            break;
            
        case SFCircleLoadingAnimationGrowThenReduce:
        {
            self.withCircle = YES;
            self.startAngleDefault = -M_PI_2;
            self.endAngleDefault = M_PI;
            self.timingFuncDefault = SFCircleLoadingTimingFuncLinear;
            self.durationDefault = 3;
        }
            break;
            
        default:
            break;
    }
}
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
    self.animationLayer.lineWidth = loadingLineWidth;
}
- (void)setLoadingLineColor:(UIColor *)loadingLineColor {
    _loadingLineColor = loadingLineColor;
    self.animationLayer.strokeColor = loadingLineColor.CGColor;
}


#pragma mark - getter
- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _circleLayer;
}
// MARK: 默认值
- (CGFloat)startAngle {
    if (_startAngle == SF_Default_Angel) {
        return self.startAngleDefault;
    }else{
        return _startAngle;
    }
}
- (CGFloat)endAngle {
    if (_endAngle == SF_Default_Angel) {
        return self.endAngleDefault;
    }else{
        return _endAngle;
    }
}
- (CFTimeInterval)duration {
    if (_duration == SF_Default_During) {
        return self.durationDefault;
    }else{
        return _duration;
    }
}
- (SFCircleLoadingTimingFunc)timingFunc {
    if (_timingFunc == SF_Default_TimingFunc) {
        return self.timingFuncDefault;
    }else{
        return _timingFunc;
    }
}


@end

