//
//  KAPieChartSlice.h
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KASliceMake(color, size, doesPopOut, amount) [KAPieChartSlice sliceWithColor:color andAmount:size andDoesPopOut:doesPopOut amountToPopOut:amount]

@interface KAPieChartSlice : NSObject
+(KAPieChartSlice *)sliceWithColor:(UIColor *)color andAmount:(float)size andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(float)amount; // create a slice.

@property (nonatomic, strong) UIColor * color; // color of slice
@property (nonatomic, assign) float size; // 'area' or how big the slice is relative to other amounts
@property (nonatomic, assign) BOOL doesPopOut; // determines if the slice 'pops out'; as in it seperates from the rest of the chart
@property (nonatomic, assign) float amountToPopOut; // determines how much the slice 'pops out' **** IMPORTANT *** IF THIS IS SET TO ANYTHING MORE THEN ~2-5, IT WILL MOST LIKELY BE CLIP. IF THIS IS A PROBLEM AND YOU CAN'T FIX IT EMAIL ME: PEARAPPS@GMAIL.COM
@end
