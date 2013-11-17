//
//  KAPieChart.h
//  PieChart
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Kenneth Ackerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KAPieChartSlice.h"
@interface KAPieChart : UIView {
    float sum;
}
@property (nonatomic, strong) NSMutableArray * slices;
+ (NSArray *)defaultColors;
- (id)initWithSize:(float)size withSlices:(NSArray *)slices; // REQUIRED initializer
- (void)addSlice:(KAPieChartSlice *)slice;
- (void)removeSlice:(KAPieChartSlice *)slice;
- (void)reset;
@end
