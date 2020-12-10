//
//  SFCheckResultView.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFCheckResultStyle) {
    SFCheckResultStyleSuccess = 0,
    SFCheckResultStyleFailure,
};

@interface SFCheckResultView : UIView
/// 样式，默认success
@property (nonatomic, assign) SFCheckResultStyle style;
/// 是否有圆环，默认有
@property (nonatomic, assign) BOOL withCircle;
// MARK: 圆环
/// 默认5
@property (nonatomic, assign) CGFloat circleLineWidth;
/// 默认grayColor
@property (nonatomic, strong) UIColor *circleLineColor;
/// 默认0.5s
@property (nonatomic, assign) CFTimeInterval circleDuration;

// MARK: 对号
/// 默认5
@property (nonatomic, assign) CGFloat successLineWidth;
/// 默认greenColor
@property (nonatomic, strong) UIColor *successLineColor;
/// 默认0.2s
@property (nonatomic, assign) CFTimeInterval successDuration;

// MARK: 错号
/// 默认5
@property (nonatomic, assign) CGFloat failureLineWidth;
/// 默认redColor
@property (nonatomic, strong) UIColor *failureLineColor;
/// 默认0.2s
@property (nonatomic, assign) CFTimeInterval failureDuration;


#pragma mark - api
- (void)start;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
