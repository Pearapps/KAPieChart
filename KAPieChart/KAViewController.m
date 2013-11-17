//
//  KAViewController.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAViewController.h"
#import "KAPieChart.h"
@interface KAViewController (){
    KAPieChart * pieChart;
}

@end

@implementation KAViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSArray * slices = @[KASliceMake([UIColor blueColor], 0.1),KASliceMake([UIColor greenColor], 0.1),KASliceMake([UIColor cyanColor], 0.1),KASliceMake([UIColor yellowColor], 0.1), KASliceMake([UIColor orangeColor], 0.1), KASliceMake([UIColor redColor], 0.1)];
    pieChart = [[KAPieChart alloc] initWithSize:300 withSlices:slices];
    [self.view addSubview:pieChart];

    [pieChart setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2)];
    
    [super viewDidLoad];
}

@end
