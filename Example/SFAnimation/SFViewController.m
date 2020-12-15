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
    SFLoadingViewA *loadingView = [[SFLoadingViewA alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:loadingView];
    loadingView.startAngle = -M_PI;
    loadingView.endAngle = M_PI_2;
    loadingView.duration = 3;
    loadingView.withGrow = YES;
    [loadingView start];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
