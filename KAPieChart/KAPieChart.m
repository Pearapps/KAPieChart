//
//  KAPieChart.m
//  PieChart
//
//  Created by Kenneth Ackerson on 10/14/11.
//  Copyright (c) 2011 Kenneth Ackerson. All rights reserved.
//
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

static inline const CGFloat KADistanceBetweenPoints(const CGPoint p1, const CGPoint p2) {
    const CGFloat dx = p2.x - p1.x;
    const CGFloat dy = p2.y - p1.y;
    return sqrt(dx*dx + dy*dy );
}


#import "KAPieChart.h"
@interface KAPieChart () {
    NSMutableArray * _slices;
    CGFloat sum; // sum of all slices size's. This makes it so the sizes are all relative and not based on a certain scale
}

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, copy) KAPieChartTappedSliceActionBlock action;
@property (nonatomic, assign) CGFloat size;
@end;

@implementation KAPieChart

- (id)initWithSize:(CGFloat)size withSlices:(NSArray *)slices {
    self = [super init];
    if (self) {
        [self setSize:size];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSlices:slices.mutableCopy];
        
    }
    return self;
}

- (void)setSize:(CGFloat)size {
    if (_size == size) {
        return;
    }
    _size = size;
    [self updateFrameFromSize];
}

- (NSMutableArray *)slices {
    if (!_slices){
        _slices = [[NSMutableArray alloc] init];
    }
    return _slices;
}

- (void)setSlices:(NSMutableArray *)slices {
    [self reset];
    
    for (KAPieChartSlice *slice in slices) {
        [self addSlice:slice];
    }
}

- (void)addSlices:(NSArray *)slices {
    for (KAPieChartSlice *slice in slices) {
        [self addSlice:slice];
    }
}

- (void)removeSlice:(KAPieChartSlice *)slice {
    if (!slice){ return; };
    sum -= slice.value;
    [self.slices removeObject:slice];
    [self setNeedsDisplay];
}

- (void)addSlice:(KAPieChartSlice *)slice {
    if (!slice){ return; };
    sum += slice.value;
    [self.slices addObject:slice];
    [self setNeedsDisplay];
}

- (void)reset {
    sum = 0;
    [self.slices removeAllObjects];
    [self updateFrameFromSize];
    [self setNeedsDisplay];
}

- (void)setTapCallback:(KAPieChartTappedSliceActionBlock)block {
    self.action = block;
    
    if (self.action && !self.tap) {
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:self.tap];
        [self.tap setDelegate:self];
    } else if (!self.action) {
        [self removeGestureRecognizer:self.tap];
        [self.tap setDelegate:nil];
        self.tap = nil;
    }
}


#pragma mark - Private

- (KAPieChartSlice *)sliceAtPoint:(CGPoint)point {
    CGFloat size = CGRectGetWidth(self.frame);
    CGPoint converted = CGPointMake(point.x , size - point.y);
    converted = CGPointMake(converted.x - size/2, converted.y - size/2);
    
    CGFloat angle = (RADIANS_TO_DEGREES(atan(converted.y/converted.x)));
    if (converted.x < 0) {
        angle += 180;
    } else if (converted.y < 0) {
        angle += 360;
    }

    angle=360-angle;
    
    
    if (angle > 270 && angle < 360) {
        angle = angle - 360;
    }
    
    for (KAPieChartSlice *currentSlice in self.slices) {
        if (angle > currentSlice.degreeInfo.startDegrees && angle < currentSlice.degreeInfo.endDegrees) {
            CGFloat pointDistance = KADistanceBetweenPoints(point, [self convertPoint:self.center fromView:[self superview]]);
            if (pointDistance >= currentSlice.amountToPopOut && pointDistance <= currentSlice.amountToPopOut + self.bounds.size.width/2 - 5) {
                return currentSlice;
            }
            
        }
    }
    return nil;
}

- (CGPoint)circleOrigin {
    return CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
}

- (void)updateFrameFromSize {
    [self setFrame:(CGRect){self.frame.origin, self.size, self.size}];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    if (sum == 0 || !self.slices || self.slices.count == 0){
        return;
    }
    const static CGFloat conversion = M_PI/180;
    
    CGPoint circleOrigin = [self circleOrigin];
    
    const CGFloat x = circleOrigin.x;
    const CGFloat y = circleOrigin.y;
    const CGFloat r = self.size/2-5;
    CGFloat startDeg = -90;
    CGFloat endDeg = 0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (KAPieChartSlice *currentSlice in self.slices){
        
        endDeg = startDeg + (currentSlice.value/sum) * 360;
        
        currentSlice.degreeInfo = (KAPieSliceAngleInfo){startDeg, endDeg};
        
        CGContextSetFillColorWithColor(ctx, currentSlice.color.CGColor);
        CGFloat tempX = x;
        CGFloat tempY = y;
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
            
            NSString *stringToDraw = nil;
            if (self.ignoresAllTitleLabelsAndDisplayPercentages){
                stringToDraw = [NSString stringWithFormat:@"%.2f%%", 100*(currentSlice.value/sum)];
            } else {
                stringToDraw = currentSlice.title;
            }
            
            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
                CGSize size = [currentSlice.title sizeWithAttributes:currentSlice.textAttributes];
                [stringToDraw drawAtPoint:CGPointMake(tempX + r*0.7*cosf(conversion *((startDeg+endDeg)/2.f)) - size.width/2, tempY + r*0.7 * sinf(conversion *((startDeg+endDeg)/2.f)) - size.height/2) withAttributes:currentSlice.textAttributes];
            }else{
                UIFont * font = currentSlice.textAttributes[NSFontAttributeName];
                [currentSlice.textAttributes[NSForegroundColorAttributeName] setFill];
                CGSize size = [currentSlice.title sizeWithFont:font];
                [stringToDraw drawAtPoint:CGPointMake(tempX + r*0.7*cosf(conversion *((startDeg+endDeg)/2.f)) - size.width/2, tempY + r*0.7 * sinf(conversion *((startDeg+endDeg)/2.f)) - size.height/2) withFont:font];
            }
        }
        CGContextRestoreGState(ctx);
        
        startDeg = endDeg;
    }
}

- (void)tapped:(UIGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    KAPieChartSlice *selectedSlice = [self sliceAtPoint:point];
    if (selectedSlice) {
        self.action(self, selectedSlice);
    }
}

- (void)dealloc{
    [self setTapCallback:nil];
    _slices = nil;
}
@end
