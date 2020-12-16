//
//  SFCircleLoadingView.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import "SFLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFCircleLoadingAnimation) {
    SFCircleLoadingAnimationRotate = 0,
    SFCircleLoadingAnimationGrowThenRotate,
    SFCircleLoadingAnimationGrowSyncRotate,
    SFCircleLoadingAnimationGrowThenReduce,
};
typedef NS_ENUM(NSUInteger, SFCircleLoadingTimingFunc) {
    SFCircleLoadingTimingFuncLinear = 0,
    SFCircleLoadingTimingFuncEaseIn,
    SFCircleLoadingTimingFuncEaseOut,
    SFCircleLoadingTimingFuncEaseInEaseOut,
};

@interface SFCircleLoadingView : SFLoadingView

// MARK: 动画
/// 动画样式
@property (nonatomic, assign) IBInspectable SFCircleLoadingAnimation animation;
/// 动画方式，默认SFCircleLoadingTimingFuncLinear
@property (nonatomic, assign) SFCircleLoadingTimingFunc timingFunc;
/// 动画时长
@property (nonatomic, assign) CFTimeInterval duration;

// MARK: 背景环
/// 是否有背景环，默认有
@property (nonatomic, assign) IBInspectable BOOL withCircle;
/// 背景环宽度，默认5
@property (nonatomic, assign) IBInspectable CGFloat circleLineWidth;
/// 背景环颜色，默认grayColor, alpha=0.1
@property (nonatomic, strong) IBInspectable UIColor *circleLineColor;

// MARK: 指示环
/// 指示环宽度，默认5
@property (nonatomic, assign) IBInspectable CGFloat loadingLineWidth;
/// 指示环颜色，默认orangeColor
@property (nonatomic, strong) IBInspectable UIColor *loadingLineColor;
/// 指示环起始角度
@property (nonatomic, assign) IBInspectable CGFloat startAngle;
/// 指示环结束角度
@property (nonatomic, assign) IBInspectable CGFloat endAngle;

@end

NS_ASSUME_NONNULL_END
