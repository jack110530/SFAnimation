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

/// 起始角度，默认-M_PI_2
@property (nonatomic, assign) CGFloat initAngle;
/// 圆弧范围，默认0.7
@property (nonatomic, assign) CGFloat rangePercent;
/// 速度，默认0.5/60.0f
@property (nonatomic, assign) CGFloat speed;

/// 默认5
@property (nonatomic, assign) CGFloat lineWidth;
/// 默认orangeColor
@property (nonatomic, strong) UIColor *lineColor;

#pragma mark - api
- (void)start;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
