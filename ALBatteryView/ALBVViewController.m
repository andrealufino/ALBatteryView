//
//  ALBVViewController.m
//  ALBatteryView
//
//  Created by Andrea Mario Lufino on 06/08/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import "ALBVViewController.h"

@interface ALBVViewController ()

@end

@implementation ALBVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ALBatteryView *batteryView = [[ALBatteryView alloc] initWithFrame:CGRectMake(20, 40, 128, 128)];
    [batteryView setCenter:self.view.center];
    [self.view addSubview:batteryView];
    [batteryView setBatteryLevelWithAnimation:YES forValue:[UIDevice currentDevice].batteryLevelInPercentage inPercent:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
