//
//  KAViewController.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAViewController.h"
#import "PieChart.h"
@interface KAViewController ()

@end

@implementation KAViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor greenColor];
    PieChart * pieChart = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, 100, 100) andNumberOfSlices:10];
    [self.view addSubview:pieChart];
    
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];
    [pieChart addSubsection:0.1];

    [super viewDidLoad];
}


@end
