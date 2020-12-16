//
//  SFLoadingView.h
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFLoadingView : UIView
<CAAnimationDelegate>
@property (nonatomic, strong, readonly) CAShapeLayer *loadingLayer;

#pragma mark - api
- (void)start;
- (void)pause;

#pragma mark - 在子类中实现
- (void)customLoadingPath;
- (BOOL)customLoadingAnimation;

@end

NS_ASSUME_NONNULL_END
