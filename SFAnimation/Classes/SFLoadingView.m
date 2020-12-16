//
//  SFLoadingView.m
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import "SFLoadingView.h"

@interface SFLoadingView ()
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
@end

@implementation SFLoadingView

#pragma mark - api
- (void)start {
    [self customLoadingAnimation];
}
- (void)pause {
    [self.loadingLayer removeAllAnimations];
}

- (void)drawRect:(CGRect)rect {
    [self customLoadingPath];
    [self.layer addSublayer:self.loadingLayer];
}

#pragma mark - 在子类中实现
- (void)customLoadingPath {
    
}
- (BOOL)customLoadingAnimation {
    return NO;
}


#pragma mark - getter
- (CAShapeLayer *)loadingLayer {
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.fillColor =  [[UIColor clearColor] CGColor];
    }
    return _loadingLayer;
}

@end

