//
//  KAPieChart.m
//  PieChart
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Kenneth Ackerson. All rights reserved.
//

#import "KAPieChart.h"
@interface KAPieChart (){
    NSMutableArray * _slices;
}
@end;
@implementation KAPieChart
+ (NSArray *)defaultColors{
    return @[[UIColor colorWithRed:1.0 green:0.0 blue:0.1 alpha:1.0],[UIColor colorWithRed:255.0/255.0 green:170.0/255.0 blue:0.0 alpha:1.0],[UIColor colorWithRed:0.2 green:0.75 blue:0.2 alpha:1.0],[UIColor colorWithRed:0.1 green:0.3 blue:1.0 alpha:1.0], [UIColor purpleColor], [UIColor cyanColor], [UIColor grayColor],[UIColor whiteColor],[UIColor yellowColor],[UIColor brownColor]];
}
- (id)initWithSize:(float)size withSlices:(NSArray *)slices
{
    self = [super initWithFrame:CGRectMake(0, 0, size, size)];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSlices:slices.mutableCopy];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width); // keep it SQUARE!!
    [super setFrame:frame];
}
- (void)recalculateSliceArray{
    sum = 0;
    for (KAPieChartSlice * slice in self.slices){
        sum += slice.size;
    }
    [self setNeedsDisplay];
}
- (NSMutableArray *)slices{
    if (!_slices){
        _slices = [[NSMutableArray alloc] init];
    }
    return _slices;
}
- (void)setSlices:(NSMutableArray *)slices{
    _slices = slices;
    [self recalculateSliceArray];
}
- (void)removeSlice:(KAPieChartSlice *)slice{
    if (!slice){ return; };
    sum -= slice.size;
    [self.slices removeObject:slice];
    [self setNeedsDisplay];
}
- (void)addSlice:(KAPieChartSlice *)slice
{
    if (!slice){ return; };
    sum += slice.size;
    [self.slices addObject:slice];
    [self setNeedsDisplay];
}
- (void)reset
{
    sum = 0;
    [self.slices removeAllObjects];
    [self recalculateSliceArray];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (sum == 0 || !self.slices || self.slices.count == 0){
        return;
    }
    const static float conversion = M_PI/180;
    const float x = self.bounds.size.width/2;
    const float y = self.bounds.size.height/2;
    const float r = self.bounds.size.width/2 - 5;
    float startDeg = -90;
    float endDeg = 0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int i = 0; i < self.slices.count; i++){
        KAPieChartSlice * currentSlice = self.slices[i];
        endDeg = startDeg + (currentSlice.size/sum) * 360;
        CGContextSetFillColorWithColor(ctx, currentSlice.color.CGColor);
        float tempX = x;
        float tempY = y;
        if (currentSlice.doesPopOut){
            CGPoint up = CGPointMake(cosf(conversion *((startDeg+endDeg)/2.f))*currentSlice.amountToPopOut, sinf(conversion *((startDeg+endDeg)/2.f))*currentSlice.amountToPopOut);
            tempX += up.x;
            tempY += up.y;
        }
        
        CGContextMoveToPoint(ctx, tempX, tempY);
        CGContextAddArc(ctx, tempX, tempY, r, startDeg*conversion, endDeg*conversion, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        CGContextSaveGState(ctx);
        if ((currentSlice.title && currentSlice.textAttributes) || (currentSlice.textAttributes && self.ignoresAllTitleLabelsAndDisplayPercentages)){
            if (self.ignoresAllTitleLabelsAndDisplayPercentages){
                currentSlice.title = [NSString stringWithFormat:@"%.2f%%", 100*(currentSlice.size/sum)];
            }
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                CGSize size = [currentSlice.title sizeWithAttributes:currentSlice.textAttributes];
                [currentSlice.title drawAtPoint:CGPointMake(tempX + r*0.7*cosf(conversion *((startDeg+endDeg)/2.f)) - size.width/2, tempY + r*0.7 * sinf(conversion *((startDeg+endDeg)/2.f)) - size.height/2) withAttributes:currentSlice.textAttributes];
            }else{
                UIFont * font = currentSlice.textAttributes[NSFontAttributeName];
                [currentSlice.textAttributes[NSForegroundColorAttributeName] setFill];
                CGSize size = [currentSlice.title sizeWithFont:font];
                [currentSlice.title drawAtPoint:CGPointMake(tempX + r*0.7*cosf(conversion *((startDeg+endDeg)/2.f)) - size.width/2, tempY + r*0.7 * sinf(conversion *((startDeg+endDeg)/2.f)) - size.height/2) withFont:font];
            }
        }
        CGContextRestoreGState(ctx);
        
        startDeg = endDeg;
    }
}
//NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        textStyle.alignment = NSTextAlignmentCenter;
- (void)dealloc{
    _slices = nil;
}
@end
