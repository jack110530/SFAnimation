//
//  SFAnimationView.m
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import "SFAnimationView.h"


@interface SFAnimationView ()
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@end

@implementation SFAnimationView

#pragma mark - api
- (void)start {
    [self customAnimation];
}
- (void)stop {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
    }
}

#pragma mark - SFAnimationProtocol
- (void)customAnimation {
    // 在子类中重写实现
}
- (void)customPath {
    // 在子类中重写实现
}


- (void)drawRect:(CGRect)rect {
    [self customPath];
    [self.layer addSublayer:self.animationLayer];
}



#pragma mark - getter
- (CAShapeLayer *)animationLayer {
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.fillColor =  [[UIColor clearColor] CGColor];
    }
    return _animationLayer;
}

@end
