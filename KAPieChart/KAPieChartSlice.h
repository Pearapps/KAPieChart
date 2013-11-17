//
//  KAPieChartSlice.h
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KASliceMake(color, size) [KAPieChartSlice sliceWithColor:color andAmount:size]

@interface KAPieChartSlice : NSObject
+(KAPieChartSlice *)sliceWithColor:(UIColor *)color andAmount:(float)size; // create a slice.

@property (nonatomic, strong) UIColor * color; // color of slice
@property (nonatomic, assign) float size; // 'area' or how big the slice is relative to other amounts
@end
