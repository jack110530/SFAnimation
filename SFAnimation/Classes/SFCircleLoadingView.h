//
//  SFCircleLoadingView.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import "SFLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFCircleLoadingAnimation) {
    SFCircleLoadingAnimationDefault = 0,
    SFCircleLoadingAnimationGrowFirst,
    SFCircleLoadingAnimationGrowSync,
};

@interface SFCircleLoadingView : SFLoadingView
@property (nonatomic, assign) SFCircleLoadingAnimation animation;
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
/// 默认-M_PI_2
@property (nonatomic, assign) CGFloat startAngle;
/// 默认-M_PI_4
@property (nonatomic, assign) CGFloat endAngle;
/// 转一圈需要多长时间，默认2s
@property (nonatomic, assign) CFTimeInterval duration;
/// 动画方式，默认kCAMediaTimingFunctionLinear
@property (nonatomic, assign) CAMediaTimingFunctionName timingFunc;



@end

NS_ASSUME_NONNULL_END