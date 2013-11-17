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
    float sum; // sum of all slices size's. This makes it so the sizes are all relative and not based on a certain scale
}
@property (readonly, strong) NSMutableArray * slices; // slices array - readonly
+ (NSArray *)defaultColors; // old method; just an array of colors
- (id)initWithSize:(float)size withSlices:(NSArray *)slices; // REQUIRED initializer
- (void)addSlice:(KAPieChartSlice *)slice; // add a slice to chart
- (void)removeSlice:(KAPieChartSlice *)slice; // remove a slice to chart
- (void)reset;
@end
