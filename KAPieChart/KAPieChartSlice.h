//
//  KAPieChartSlice.h
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//
typedef struct {
    CGFloat startDegrees;
    CGFloat endDegrees;
} KAPieSliceAngleInfo;
#import <Foundation/Foundation.h>

#define KASliceMake(color, size, doesPopOut, amountOfPoppingOut, title, attributes) [KAPieChartSlice sliceWithColor:color andAmount:size andDoesPopOut:doesPopOut amountToPopOut:amountOfPoppingOut withTitle:title andAttributes:attributes]

@interface KAPieChartSlice : NSObject
+ (KAPieChartSlice *)sliceWithColor:(UIColor *)color andValue:(CGFloat)value andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(CGFloat)amount withTitle:(NSString *)title andAttributes:(NSDictionary *)attributes; // create a slice. ***Pass nil for title and attributes if you dont want them***


- (instancetype)initWithColor:(UIColor *)color andValue:(CGFloat)value andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(CGFloat)amount withTitle:(NSString *)title andAttributes:(NSDictionary *)attributes; // Designated Initializer

- (void)setTitle:(NSString *)title andAttributes:(NSDictionary *)attributes;

@property (nonatomic, strong) UIColor * color; // color of slice
@property (nonatomic, assign) CGFloat value; // 'area' or how big the slice is relative to other amounts

@property (nonatomic, copy) NSString *title; // Label to draw on slice.
@property (nonatomic, strong) NSDictionary * textAttributes; // atrributes of label to draw

@property (nonatomic, assign) BOOL doesPopOut; // determines if the slice 'pops out'; as in it seperates from the rest of the chart
@property (nonatomic, assign) CGFloat amountToPopOut; // determines how much the slice 'pops out' **** IMPORTANT *** IF THIS IS SET TO ANYTHING MORE THEN ~2-5, IT WILL MOST LIKELY BE CLIP. IF THIS IS A PROBLEM AND YOU CAN'T FIX IT EMAIL ME: PEARAPPS@GMAIL.COM



/**

 
 */
@property (nonatomic, assign) KAPieSliceAngleInfo degreeInfo;

@end
