//
//  SFViewController.m
//  SFAnimation
//
//  Created by jack110530 on 12/10/2020.
//  Copyright (c) 2020 jack110530. All rights reserved.
//

#import "SFViewController.h"

#import <SFAnimation/SFAnimation.h>

@interface SFViewController ()

@property (weak, nonatomic) IBOutlet SFCheckResultView *xibView;

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SFCircleLoadingView *loadingView = [[SFCircleLoadingView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:loadingView];
    /*
     SFCircleLoadingAnimationRotate = 0,
     SFCircleLoadingAnimationGrowThenRotate,
     SFCircleLoadingAnimationGrowSyncRotate,
     SFCircleLoadingAnimationGrowThenReduce,
     SFCircleLoadingAnimationGrowThenReduceSyncRotate,
    */
    loadingView.animation = SFCircleLoadingAnimationGrowThenReduceSyncRotate;
    loadingView.loadingLineColor = [UIColor redColor];
    [loadingView start];
    
    
//    self.xibView.borderLineColor = [UIColor blackColor];
//    self.xibView.borderLineWidth = 2;
    self.xibView.borderDuration = 2;
//    self.xibView.resultLineColor = [UIColor blueColor];
//    self.xibView.resultLineWidth = 2;
    self.xibView.resultDuration = 1;
    self.xibView.resultScale = 0.8;
    self.xibView.roundCap = NO;
    
    [self.xibView start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
