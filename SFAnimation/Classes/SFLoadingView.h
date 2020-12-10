//
//  SFLoadingView.h
//  OCTestDemo
//
//  Created by 黄山锋 on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFLoadingView : UIView


/// 默认60
@property (nonatomic, assign) CGFloat radius;

/// 默认5
@property (nonatomic, assign) CGFloat lineWidth;

/// 默认orangeColor
@property (nonatomic, strong) UIColor *lineColor;

#pragma mark - api
- (void)start;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
