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
    [[self customAnimationLayer] removeAllAnimations];
}

- (void)drawRect:(CGRect)rect {
    [self customPath];
    [self.layer addSublayer:[self customAnimationLayer]];
}

#pragma mark - 在子类中实现
- (CAShapeLayer *)customAnimationLayer {
    return self.animationLayer;
}
- (BOOL)customAnimation {
    return NO;
}
- (void)customPath {
    
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
