//
//  SFCheckResultView.m
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/10.
//

#import "SFCheckResultView.h"

@interface SFCheckResultView ()
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@end

IB_DESIGNABLE
@implementation SFCheckResultView

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
    if (self.withBorder) {
        [self configCirclePath];
        [self.layer insertSublayer:self.borderLayer atIndex:0];
    }else{
        [self.borderLayer removeFromSuperlayer];
    }
    [super drawRect:rect];
}

#pragma mark - config
- (void)config {
    self.success = YES;
    self.borderDuration = 0.3;
    self.resultDuration = 0.6;
    [self configBorderLayer];
    [self configAnimationLayer];
}
- (void)configBorderLayer {
    self.borderLayer.lineCap = kCALineCapRound;
    self.borderLineWidth = 5;
}
- (void)configAnimationLayer {
    self.animationLayer.lineCap = kCALineCapRound;
    self.resultLineWidth = 5;
}
- (void)configCirclePath {
    self.borderLayer.frame = self.bounds;
    CGFloat radius = self.bounds.size.width/2.0f - self.borderLineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.borderLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    self.borderLayer.path = path.CGPath;
}


#pragma mark - custom
- (void)customAnimation {
    if (self.withBorder) {
        // border
        CABasicAnimation *anmi_border;
        {
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            anim.fromValue = [NSNumber numberWithFloat:0.0];
            anim.toValue = [NSNumber numberWithFloat:1.0];
            anim.removedOnCompletion = NO;
            anim.fillMode = kCAFillModeForwards;
            anim.beginTime = CACurrentMediaTime() + 0;
            anim.duration = self.borderDuration;
            anim.repeatCount = 1;
            anmi_border = anim;
            [self.borderLayer addAnimation:anim forKey:@"anmi_border"];
        }
        // result
        self.animationLayer.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.borderDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.animationLayer.hidden = NO;
            [self resultAnimation];
        });
    }else{
        // result
        [self resultAnimation];
    }
}
- (void)resultAnimation {
    CABasicAnimation *anmi_result;
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.beginTime = CACurrentMediaTime() + 0;
        anim.duration = self.resultDuration;
        anim.repeatCount = 1;
        anmi_result = anim;
        [self.animationLayer addAnimation:anim forKey:@"anmi_result"];
    }
}
- (void)customPath {
    CGFloat width = self.bounds.size.width;
    self.animationLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (self.success) {
        [path moveToPoint:CGPointMake(width*2.7/10,width*5.4/10)];
        [path addLineToPoint:CGPointMake(width*4.5/10,width*7/10)];
        [path addLineToPoint:CGPointMake(width*7.8/10,width*3.8/10)];
    }else{
        [path moveToPoint:CGPointMake(width*3.0/10.0,width*3.0/10.0)];
        [path addLineToPoint:CGPointMake(width*7.0/10.0,width*7.0/10.0)];
        [path moveToPoint:CGPointMake(width*7.0/10.0,width*3.0/10.0)];
        [path addLineToPoint:CGPointMake(width*3.0/10.0,width*7.0/10.0)];
    }
    self.animationLayer.path = path.CGPath;
}


#pragma mark - setter
- (void)setSuccess:(BOOL)success {
    _success = success;
    if (success) {
        self.borderLineColor = [[UIColor greenColor] colorWithAlphaComponent:0.1];
        self.resultLineColor = [UIColor greenColor];
    }else{
        self.borderLineColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
        self.resultLineColor = [UIColor redColor];
    }
}
- (void)setBorderLineWidth:(CGFloat)borderLineWidth {
    _borderLineWidth = borderLineWidth;
    self.borderLayer.lineWidth = borderLineWidth;
}
- (void)setBorderLineColor:(UIColor *)borderLineColor {
    _borderLineColor = borderLineColor;
    self.borderLayer.strokeColor = borderLineColor.CGColor;
}
- (void)setResultLineWidth:(CGFloat)resultLineWidth {
    _resultLineWidth = resultLineWidth;
    self.animationLayer.lineWidth = resultLineWidth;
}
- (void)setResultLineColor:(UIColor *)resultLineColor {
    _resultLineColor = resultLineColor;
    self.animationLayer.strokeColor = resultLineColor.CGColor;
}

#pragma mark - getter
- (CAShapeLayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _borderLayer;
}

@end
