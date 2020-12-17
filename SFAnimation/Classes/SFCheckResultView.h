//
//  SFCheckResultView.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/10.
//

#import "SFAnimationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFCheckResultView : SFAnimationView

// MARK: 边框
/// 是否有边框，默认有
@property (nonatomic, assign) IBInspectable BOOL withBorder;
/// 边框宽度，默认5
@property (nonatomic, assign) IBInspectable CGFloat borderLineWidth;
/// 边框颜色，默认：对号（greenColor，alpha=0.1）错号（redColor，alpha=0.1）
@property (nonatomic, strong) IBInspectable UIColor *borderLineColor;
/// 边框动画时长，默认0.3s
@property (nonatomic, assign) CFTimeInterval borderDuration;

// MARK: result（对号/错号）
/// true对号，false错号，默认true
@property (nonatomic, assign) IBInspectable BOOL success;
/// result宽度，默认5
@property (nonatomic, assign) IBInspectable CGFloat resultLineWidth;
/// result颜色，默认：对号（greenColor）错号（redColor）
@property (nonatomic, strong) IBInspectable UIColor *resultLineColor;
/// result缩放比例（0~1）默认0.8
@property (nonatomic, assign) IBInspectable double resultScale;
/// 是否圆形端点，默认true
@property (nonatomic, assign) IBInspectable BOOL roundCap;
/// result动画时长，默认0.6s
@property (nonatomic, assign) CFTimeInterval resultDuration;

@end

NS_ASSUME_NONNULL_END
