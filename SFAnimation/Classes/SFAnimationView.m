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
- (void)pause {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
    }
}

- (void)drawRect:(CGRect)rect {
    [self customPath];
    [self.layer addSublayer:self.animationLayer];
}

#pragma mark - custom
- (void)customAnimation {
#warning 在子类中自定义
}
- (void)customPath {
#warning 在子类中自定义
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
