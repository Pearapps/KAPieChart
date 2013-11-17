//
//  KAPieChartSlice.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPieChartSlice.h"

@implementation KAPieChartSlice
+(KAPieChartSlice *)sliceWithColor:(UIColor *)color andAmount:(float)size{
    KAPieChartSlice * p = [[KAPieChartSlice alloc] init];
    p.size = size;
    p.color = color;
    return p;
}

- (void)dealloc{
    self.color = nil;
}
@end
