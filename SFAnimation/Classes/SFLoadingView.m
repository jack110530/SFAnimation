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
    BOOL isCustom = [self customLoadingAnimation];
    if (isCustom) {
        [self.layer addSublayer:self.loadingLayer];
    }
}
- (void)pause {
    [self.loadingLayer removeFromSuperlayer];
}


- (void)drawRect:(CGRect)rect {
    [self customLoadingPath];
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

