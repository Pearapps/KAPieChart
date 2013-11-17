//
//  KAPieChartSlice.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPieChartSlice.h"

@implementation KAPieChartSlice
+(KAPieChartSlice *)sliceWithColor:(UIColor *)color andAmount:(float)size andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(float)amount{
    KAPieChartSlice * p = [[KAPieChartSlice alloc] init];
    p.size = size;
    p.color = color;
    p.doesPopOut = doesPopOut;
    p.amountToPopOut = amount;
    return p;
}

- (void)dealloc{
    self.color = nil;
}
@end
