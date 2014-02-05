//
//  KAPieChart.h
//  PieChart
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Kenneth Ackerson. All rights reserved.
//

@class KAPieChart, KAPieChartSlice;

typedef void (^KAPieChartTappedSliceActionBlock)(KAPieChart *chart, KAPieChartSlice *slice);

#import <UIKit/UIKit.h>
#import "KAPieChartSlice.h"

@interface KAPieChart : UIView <UIGestureRecognizerDelegate>

@property (readonly, strong) NSMutableArray * slices; // slices array - readonly
@property (nonatomic, assign) BOOL ignoresAllTitleLabelsAndDisplayPercentages; //Will need to have text attributes set but will display percentages instead of any titles that may have been set or not set

- (id)initWithSize:(CGFloat)size withSlices:(NSArray *)slices; // REQUIRED initializer
- (void)addSlice:(KAPieChartSlice *)slice; // add a slice to chart
- (void)removeSlice:(KAPieChartSlice *)slice; // remove a slice to chart
- (void)addSlices:(NSArray *)slices; // Adds slices
- (void)reset;

- (void)setTapCallback:(KAPieChartTappedSliceActionBlock)block;


- (void)setSize:(CGFloat)size;

@end
