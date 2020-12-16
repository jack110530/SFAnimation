//
//  SFAnimationView.h
//  SFAnimation
//
//  Created by 黄山锋 on 2020/12/16.
//

#import <UIKit/UIKit.h>
#import "SFAnimationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFAnimationView : UIView <SFAnimationProtocol>

@property (nonatomic, strong, readonly) CAShapeLayer *animationLayer;

@end

NS_ASSUME_NONNULL_END
