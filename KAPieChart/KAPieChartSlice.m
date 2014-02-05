//
//  KAPieChartSlice.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAPieChartSlice.h"

@implementation KAPieChartSlice
+ (KAPieChartSlice *)sliceWithColor:(UIColor *)color andValue:(CGFloat)value andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(CGFloat)amount withTitle:(NSString *)title andAttributes:(NSDictionary *)attributes {
    return [[KAPieChartSlice alloc] initWithColor:color andValue:value andDoesPopOut:doesPopOut amountToPopOut:amount withTitle:title andAttributes:attributes];
}

- (instancetype)initWithColor:(UIColor *)color andValue:(CGFloat)value andDoesPopOut:(BOOL)doesPopOut amountToPopOut:(CGFloat)amount withTitle:(NSString *)title andAttributes:(NSDictionary *)attributes {
    if (self = [super init]) {
        self.value = value;
        self.color = color;
        self.doesPopOut = doesPopOut;
        self.amountToPopOut = amount;
        [self setTitle:title andAttributes:attributes];
    }
    return self;
}

- (void)setTitle:(NSString *)title andAttributes:(NSDictionary *)attributes {
    self.title = title;
    self.textAttributes = attributes;
}


#pragma mark - Private


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - \"%@\"", [super description],self.title];
}

- (void)dealloc {
    self.textAttributes = nil;
    self.title = nil;
    self.color = nil;
}
@end
