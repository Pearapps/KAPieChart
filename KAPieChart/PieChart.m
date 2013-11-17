//
//  PieChart.m
//  SystemInfo
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Pearapps. All rights reserved.
//

#import "PieChart.h"
@implementation PieChart

- (id)initWithFrame:(CGRect)frame andNumberOfSlices:(int)slices
{
    self = [super initWithFrame:frame];
    if (self) {
        
        items = malloc(sizeof(float) * slices);
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setColors:nil];
    }
    return self;
}
- (NSArray *)defaultColors{
    return @[[UIColor colorWithRed:1.0 green:0.0 blue:0.1 alpha:1.0],[UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0.0 alpha:1.0],[UIColor colorWithRed:0.2 green:0.75 blue:0.2 alpha:1.0],[UIColor colorWithRed:0.1 green:0.3 blue:1.0 alpha:1.0], [UIColor purpleColor], [UIColor cyanColor], [UIColor grayColor],[UIColor whiteColor],[UIColor yellowColor],[UIColor brownColor]];
}
- (void)setColors:(NSArray *)colors{
    if (!colors){
        [self setColors:[self defaultColors]];
        return;
    }
    _colors = colors;
    NSLog(@"%@", _colors);
   // [self setNeedsDisplay];
}
- (void)addSubsection:(const float)sub
{
    sum += sub;
    items[count++] = sub;
}
- (void)reset
{
    sum = 0;
    count = 0;
}

- (void)drawRect:(CGRect)rect
{
    if (sum == 0){
        return;
    }

    const static float conversion = M_PI/180;
    const float x = self.bounds.size.width/2;
    const float y = self.bounds.size.height/2;
    const float r = self.bounds.size.width/2 - 2;
    float startDeg = -90;
    float endDeg = 0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//   CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
//    CGContextSetLineWidth(ctx, 2.0);
    
    for (int i = 0; i < count; i++){
        endDeg = startDeg + (items[i]/sum) * 360;
        CGContextSetFillColorWithColor(ctx, ((UIColor *) self.colors[i]).CGColor);
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, r, startDeg*conversion, endDeg*conversion, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        startDeg = endDeg;
    }
}

- (void)dealloc{
    self.colors = nil;
    free(items);
}
@end
