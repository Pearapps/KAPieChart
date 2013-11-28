//
//  KAPieChartSlice.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPieChartSlice.h"

@implementation KAPieChartSlice
+ (KAPieChartSlice *)sliceWithColor:(UIColor *)color andAmount:(float)size andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(float)amount withTitle:(NSString *)title andAttributes:(NSDictionary *)attributes{
    KAPieChartSlice * p = [[KAPieChartSlice alloc] init];
    p.size = size;
    p.color = color;
    p.doesPopOut = doesPopOut;
    p.amountToPopOut = amount;
    [p setTitle:title andAttributes:attributes];
    return p;
}
- (void)setTitle:(NSString *)title andAttributes:(NSDictionary *)attributes{
    self.title = title;
    self.textAttributes = attributes;
}
- (void)dealloc{
    self.textAttributes = nil;
    self.title = nil;
    self.color = nil;
}
@end
