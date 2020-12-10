//
//  SFViewController.m
//  SFAnimation
//
//  Created by jack110530 on 12/10/2020.
//  Copyright (c) 2020 jack110530. All rights reserved.
//

#import "SFViewController.h"

#import <SFAnimation/SFLoadingView.h>
#import <SFAnimation/SFCheckResultView.h>

@interface SFViewController ()

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SFLoadingView *loadingView = [[SFLoadingView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:loadingView];
    loadingView.rangePercent = 0.5;
    loadingView.speed = 0.5/60.f;
    [loadingView start];
    
    SFCheckResultView *resultView = [[SFCheckResultView alloc]initWithFrame:CGRectMake(100, 400, 100, 100)];
    [self.view addSubview:resultView];
//    resultView.circleDuration = 0.2;
//    resultView.circleLineWidth = 10;
//    resultView.circleLineColor = [UIColor blackColor];
//    resultView.successDuration = 1;
//    resultView.successLineColor = [UIColor redColor];
//    resultView.successLineWidth = 10;
    resultView.style = 1;
    [resultView start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
