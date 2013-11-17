//
//  PieChart.h
//  SystemInfo
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Pearapps. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PieChart : UIView {
    float *items;
    int count;
    float sum;
}
@property (nonatomic, assign) NSArray * colors;

- (id)initWithFrame:(CGRect)frame andNumberOfSlices:(int)slices; // REQUIRED initializer
- (void)addSubsection:(const float)sub;
- (void)reset;
@end
