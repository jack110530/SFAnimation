//
//  SFLoadingView.h
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFLoadingStyle) {
    SFLoadingStyleDefault,
};

@interface SFLoadingView : UIView
<CAAnimationDelegate>

/// 是否有圆环，默认有
@property (nonatomic, assign) IBInspectable BOOL withCircle;

// MARK: 圆环
/// 默认5
@property (nonatomic, assign) IBInspectable CGFloat circleLineWidth;
/// 默认grayColor, alpha=0.1
@property (nonatomic, strong) IBInspectable UIColor *circleLineColor;

// MARK: 指示环
/// 默认5
@property (nonatomic, assign) CGFloat loadingLineWidth;
/// 默认orangeColor
@property (nonatomic, strong) UIColor *loadingLineColor;


#pragma mark - api
- (void)start;
- (void)pause;

#pragma mark - 在子类中实现
- (void)customLoadingPath;
- (BOOL)customLoadingAnimation;

@end


#pragma mark - SFLoadingViewA
@interface SFLoadingViewA : SFLoadingView
/// 默认-M_PI_2
@property (nonatomic, assign) CGFloat startAngle;
/// 默认-M_PI_4
@property (nonatomic, assign) CGFloat endAngle;
/// 转一圈需要多长时间，默认2s
@property (nonatomic, assign) CFTimeInterval duration;
/// 动画方式，默认kCAMediaTimingFunctionLinear
@property (nonatomic, assign) CAMediaTimingFunctionName timingFunc;
/// 是否从0增长
@property (nonatomic, assign) BOOL withGrow;

@end


#pragma mark - SFLoadingViewB
@interface SFLoadingViewB : SFLoadingView
/// 默认-M_PI_2
@property (nonatomic, assign) CGFloat startAngle;
/// 默认-M_PI_4
@property (nonatomic, assign) CGFloat endAngle;


@end


NS_ASSUME_NONNULL_END
