//
//  SFAnimationProtocol.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFCircleLoadingTimingFunc) {
    SFCircleLoadingTimingFuncLinear = 0,
    SFCircleLoadingTimingFuncEaseIn,
    SFCircleLoadingTimingFuncEaseOut,
    SFCircleLoadingTimingFuncEaseInEaseOut,
};

@protocol SFAnimationProtocol <NSObject, CAAnimationDelegate>

#pragma mark - api
/// 开始动画
- (void)start;
/// 结束动画
- (void)stop;

#pragma mark - 在子类中实现
- (void)customPath;
- (void)customAnimation;

@end

NS_ASSUME_NONNULL_END
