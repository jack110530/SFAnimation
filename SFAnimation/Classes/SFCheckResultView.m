//
//  SFCheckResultView.m
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/10.
//

#import "SFCheckResultView.h"

@interface SFCheckResultView ()
<CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *successLayer;
@property (nonatomic, strong) CAShapeLayer *failureLayer;
@property (nonatomic, strong) CABasicAnimation *circleAnimation;
@property (nonatomic, strong) CABasicAnimation *successAnimation;
@property (nonatomic, strong) CABasicAnimation *failureAnimation;
@property (nonatomic, assign) NSInteger animationPhase; // 0:circleAnimation 1:successAnimation 2:failureAnimation
@end

@implementation SFCheckResultView

#pragma mark - api
- (void)start {
    NSInteger animationPhase = 0;
    if (self.withCircle) {
        animationPhase = 0;
    }else{
        switch (self.style) {
            case SFCheckResultStyleSuccess:
            {
                animationPhase = 1;
            }
                break;
                
            case SFCheckResultStyleFailure:
            {
                animationPhase = 2;
            }
                break;
                
            default:
                break;
        }
    }
    [self startAnimationWithPhase:animationPhase];
}
// 0:circleAnimation 1:successAnimation 2:failureAnimation
- (void)startAnimationWithPhase:(NSInteger)phase {
    self.animationPhase = phase;
    if (phase == 0) {
        [self.layer addSublayer:self.circleLayer];
        [self.circleLayer addAnimation:self.circleAnimation forKey:nil];
    }
    else if (phase == 1) {
        [self.layer addSublayer:self.successLayer];
        [self.successLayer addAnimation:self.successAnimation forKey:nil];
    }
    else if (phase == 2) {
        [self.layer addSublayer:self.failureLayer];
        [self.failureLayer addAnimation:self.failureAnimation forKey:nil];
    }
}
- (void)pause {
    [self.circleLayer removeFromSuperlayer];
    [self.successLayer removeFromSuperlayer];
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
    [self configCircleAnimation];
    [self configSuccessAnimation];
    [self configFailureAnimation];
}
- (void)drawRect:(CGRect)rect {
    // 圆环
    if (self.withCircle) {
        [self configCirclePath];
    }
    switch (self.style) {
        case SFCheckResultStyleSuccess:
        {
            [self configSuccessPath]; // 对号
        }
            break;
            
        case SFCheckResultStyleFailure:
        {
            [self configFailurePath]; // 错号
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - configAnimation
- (void)configCircleAnimation {
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.circleLayer.lineCap = kCALineCapRound;
    
    self.circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.circleAnimation.fromValue = @(0.0f);
    self.circleAnimation.toValue = @(1.0f);
    self.circleAnimation.delegate = self;
    [self.circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    
    self.circleLineWidth = 5;
    self.circleLineColor = [UIColor grayColor];
    self.circleDuration = 0.5;
}

- (void)configSuccessAnimation {
    self.successLayer = [CAShapeLayer layer];
    self.successLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.successLayer.lineCap = kCALineCapRound;
    
    self.successAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.successAnimation.fromValue = @(0.0f);
    self.successAnimation.toValue = @(1.0f);
    self.successAnimation.delegate = self;
    [self.successAnimation setValue:@"successAnimation" forKey:@"animationName"];
    
    self.successLineWidth = 5;
    self.successLineColor = [UIColor greenColor];
    self.successDuration = 0.2;
}

- (void)configFailureAnimation {
    self.failureLayer = [CAShapeLayer layer];
    self.failureLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.failureLayer.lineCap = kCALineCapRound;
    
    self.failureAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.failureAnimation.fromValue = @(0.0f);
    self.failureAnimation.toValue = @(1.0f);
    self.failureAnimation.delegate = self;
    [self.failureAnimation setValue:@"failureAnimation" forKey:@"animationName"];
    
    self.failureLineWidth = 5;
    self.failureLineColor = [UIColor redColor];
    self.failureDuration = 0.2;
}


#pragma mark - configPath
- (void)configCirclePath {
    self.circleLayer.frame = self.bounds;
    CGFloat radius = self.bounds.size.width/2.0f - self.circleLineWidth/2.0f;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    self.circleLayer.path = circlePath.CGPath;
}
- (void)configSuccessPath {
    CGFloat width = self.bounds.size.width;
    self.successLayer.frame = self.bounds;
    UIBezierPath *successPath = [UIBezierPath bezierPath];
    [successPath moveToPoint:CGPointMake(width*2.7/10,width*5.4/10)];
    [successPath addLineToPoint:CGPointMake(width*4.5/10,width*7/10)];
    [successPath addLineToPoint:CGPointMake(width*7.8/10,width*3.8/10)];
    self.successLayer.path = successPath.CGPath;
}
- (void)configFailurePath {
    CGFloat width = self.bounds.size.width;
    self.failureLayer.frame = self.bounds;
    UIBezierPath *fialurePath = [UIBezierPath bezierPath];
    [fialurePath moveToPoint:CGPointMake(width*3.0/10.0,width*3.0/10.0)];
    [fialurePath addLineToPoint:CGPointMake(width*7.0/10.0,width*7.0/10.0)];
    [fialurePath moveToPoint:CGPointMake(width*7.0/10.0,width*3.0/10.0)];
    [fialurePath addLineToPoint:CGPointMake(width*3.0/10.0,width*7.0/10.0)];
    self.failureLayer.path = fialurePath.CGPath;
}



#pragma mark - delegate
- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.animationPhase == 0 && flag) {
        NSInteger animationPhase = 1;
        switch (self.style) {
            case SFCheckResultStyleSuccess:
            {
                animationPhase = 1;
            }
                break;
                
            case SFCheckResultStyleFailure:
            {
                animationPhase = 2;
            }
                break;
                
            default:
                break;
        }
        [self startAnimationWithPhase:animationPhase];
    }
}



#pragma mark - setter
- (void)setStyle:(SFCheckResultStyle)style {
    _style = style;
}
- (void)setCircleLineWidth:(CGFloat)circleLineWidth {
    _circleLineWidth = circleLineWidth;
    self.circleLayer.lineWidth = circleLineWidth;
}
- (void)setCircleLineColor:(UIColor *)circleLineColor {
    _circleLineColor = circleLineColor;
    self.circleLayer.strokeColor = circleLineColor.CGColor;
}
- (void)setCircleDuration:(CFTimeInterval)circleDuration {
    _circleDuration = circleDuration;
    self.circleAnimation.duration = circleDuration;
}
- (void)setSuccessLineWidth:(CGFloat)successLineWidth {
    _successLineWidth = successLineWidth;
    self.successLayer.lineWidth = successLineWidth;
}
- (void)setSuccessLineColor:(UIColor *)successLineColor {
    _successLineColor = successLineColor;
    self.successLayer.strokeColor = successLineColor.CGColor;
}
- (void)setSuccessDuration:(CFTimeInterval)successDuration {
    _successDuration = successDuration;
    self.successAnimation.duration = successDuration;
}
- (void)setFailureLineWidth:(CGFloat)failureLineWidth {
    _failureLineWidth = failureLineWidth;
    self.failureLayer.lineWidth = failureLineWidth;
}
- (void)setFailureLineColor:(UIColor *)failureLineColor {
    _failureLineColor = failureLineColor;
    self.failureLayer.strokeColor = failureLineColor.CGColor;
}
- (void)setFailureDuration:(CFTimeInterval)failureDuration {
    _failureDuration = failureDuration;
    self.failureAnimation.duration = failureDuration;
}


#pragma mark - getter

@end
