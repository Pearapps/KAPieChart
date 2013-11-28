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
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName: [UIColor blackColor]};

    NSArray * slices = @[KASliceMake([UIColor blueColor], 0.1, NO , 0, nil, attributes), // KASliceMake is a macro to create slices that takes less space then the default way
                         KASliceMake([UIColor greenColor], 0.1, NO, 0, nil, attributes),
                         KASliceMake([UIColor cyanColor], 0.1, NO, 0, nil,attributes),
                         KASliceMake([UIColor yellowColor], 0.1,NO, 0, nil, attributes),
                         KASliceMake([UIColor orangeColor], 0.1, NO, 0, nil, attributes),
                         [KAPieChartSlice sliceWithColor:[UIColor redColor] andAmount:0.2 andDoesPopOut:YES amountToPopOut:5 withTitle:nil andAttributes:attributes], // *** another way to create a slice
                         ];
    
    pieChart = [[KAPieChart alloc] initWithSize:250 withSlices:slices];
    
    //[pieChart setIgnoresAllTitleLabelsAndDisplayPercentages:YES]; // shows percentages instead of title labels ***NEEDS textAttributes set on every slice that wants to display percentage***
    
    [self.view addSubview:pieChart];
    [pieChart setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2)];
    
    [super viewDidLoad];
}

@end
