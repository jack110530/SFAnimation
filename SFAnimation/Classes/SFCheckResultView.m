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
    self.resultScale = 0.8;
    self.roundCap = YES;
    [self configBorderLayer];
    [self configAnimationLayer];
}
- (void)configBorderLayer {
    self.borderLineWidth = 5;
}
- (void)configAnimationLayer {
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
    // 圆形
    CGFloat r = width/2.0f - self.borderLineWidth;
    CGFloat x_min = r - r*cos(M_PI_4) + self.borderLineWidth;
    CGFloat x_max = r + r*cos(M_PI_4) + self.borderLineWidth;
    CGFloat y_min = x_min;
    CGFloat y_max = x_max;
    CGFloat x_range = x_max - x_min;
    CGFloat y_range = y_max - y_min;
    CGFloat scale = 1-self.resultScale;
    CGFloat x_adding = x_range/2.0f *scale;
    CGFloat y_adding = y_range/2.0f *scale;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (self.success) {
        CGFloat offset1 = x_range * self.resultScale * (1.0f/3.0f);
        CGFloat offset2 = x_range * self.resultScale * (2.0f/3.0f);
        CGFloat y_offset = -offset1/2; // 整体向上偏移
        CGPoint p1 = CGPointMake(x_min+x_adding,y_min+y_adding+offset2+y_offset);
        CGPoint p2 = CGPointMake(x_min+x_adding+offset1,y_max-y_adding+y_offset);
        CGPoint p3 = CGPointMake(x_max-x_adding,y_min+y_adding+offset1+y_offset);
        [path moveToPoint:p1];
        [path addLineToPoint:p2];
        [path addLineToPoint:p3];
    }else{
        CGPoint p10 = CGPointMake(x_min+x_adding,y_min+y_adding);
        CGPoint p11 = CGPointMake(x_max-x_adding,y_max-y_adding);
        CGPoint p20 = CGPointMake(x_max-x_adding,y_min+y_adding);
        CGPoint p21 = CGPointMake(x_min+x_adding,y_max-y_adding);
        [path moveToPoint:p10];
        [path addLineToPoint:p11];
        [path moveToPoint:p20];
        [path addLineToPoint:p21];
    }
    self.animationLayer.path = path.CGPath;
}


#pragma mark - setter
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
- (void)setResultScale:(CGFloat)resultScale {
    if (resultScale>1) {
        resultScale = 1.0;
    }
    if (resultScale < 0) {
        resultScale = 0;
    }
    _resultScale = resultScale;
    [self setNeedsDisplay];
}
- (void)setRoundCap:(BOOL)roundCap {
    _roundCap = roundCap;
    self.borderLayer.lineCap = self.roundCap ? kCALineCapRound : kCALineCapButt;
    self.animationLayer.lineCap = self.roundCap ? kCALineCapRound : kCALineCapButt;
    [self setNeedsDisplay];
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
