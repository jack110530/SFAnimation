//
//  SFAnimationProtocol.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SFAnimationProtocol <NSObject, CAAnimationDelegate>

#pragma mark - api
- (void)start;
- (void)pause;

#pragma mark - 在子类中实现
- (CAShapeLayer *)customAnimationLayer;
- (void)customPath;
- (BOOL)customAnimation;

@end

NS_ASSUME_NONNULL_END
