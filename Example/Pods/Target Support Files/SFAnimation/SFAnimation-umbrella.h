#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SFAnimation.h"
#import "SFAnimationProtocol.h"
#import "SFAnimationView.h"
#import "SFCheckResultView.h"
#import "SFCircleLoadingView.h"

FOUNDATION_EXPORT double SFAnimationVersionNumber;
FOUNDATION_EXPORT const unsigned char SFAnimationVersionString[];

