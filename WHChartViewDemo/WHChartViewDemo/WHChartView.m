//
//  WHChart.m
//  WHChartView
//
//  Created by 王振辉 on 15/8/15.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//
#import "UIColor+WHColor.h"
#import "WHChartView.h"
#import "WHChartBar.h"
@interface WHChartView (){
    CGPoint origin;                 //origin of coordinates
    CGPoint xEnd;                   //terminal point of X-axis
    CGPoint yEnd;                   //terminal point of Y-axis
    
    float singleBarSpaceWidth;      //Width of space where bar is in
    float barWidth;                 //Width of bar
    float barHeight;                //height of bar
    
    float spaceBetweenYandLeft;     //distance between Y-axis and left side of chart
    float spaceBetweenXandBottom;   //distance between X-axis and bottom side of chart
    
    float maxOfFloatData;           //max number of data
    float minOfFloatData;           //min number of data
    int   maxOfIntData;
}

@property (nonatomic, strong) NSMutableArray *data;     //store data
@property (nonatomic, strong) NSMutableArray *layers;   //store layers
@end

@implementation WHChartView

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

//init property and some default
- (void)commonInit
{
    spaceBetweenXandBottom = 25.0 - 2;
    spaceBetweenYandLeft = 25.0 +8;
    xEnd = CGPointMake(self.frame.size.width - 2, self.frame.size.height -spaceBetweenXandBottom);
    yEnd = CGPointMake(spaceBetweenYandLeft , 10);
    origin = CGPointMake(spaceBetweenYandLeft, self.frame.size.height - spaceBetweenXandBottom);
    
    self.backgroundColor = [UIColor whiteColor];
    
    _title = nil;
    _colorOfTitle = [UIColor whAsbestos];
    _colorOfXYLabel = [UIColor lightGrayColor];
    
    _colorOfAxis = [UIColor whClouds];
    _showsGridding = NO;
    _colorOfGridding = _colorOfAxis;
    _showsXLabel = YES;
    
    _drawsBarChart = YES;
    _colorOfBar = [UIColor whLightBlue];
    _colorOfUnusedPartOfBar = [UIColor clearColor];
    _showsShadowOfBar = NO;
    _colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    _angleOfShadow = 30.0;
    _animationDurationOfBar = 1.5;
    _animationDurationOfLine = 1.0;
    
    _drawsLineChart = NO;
    _colorOfLine = [UIColor grayColor];
    _lineWidth = 2.0;
    
    _smoothesLine = YES;
    _kOfBezierPath = 0.25;
    
    _showsGradientColor = YES;
    _gradientColors = [NSArray arrayWithObjects:(id)[UIColor whGreen].CGColor ,(id)[UIColor whOrange].CGColor,(id)[UIColor whAlizarin].CGColor, nil];
    _gradientStartPoint = CGPointMake(0.5, 0);
    _gradientEndPoint = CGPointMake(0.5, 1);
    _gradientLocations = @[@0.2,@0.5,@0.9 ];
}

#pragma mark - Overwrite Setter
- (void)setChartData:(NSArray *)chartData
{
    _data = [NSMutableArray arrayWithArray:chartData];
    
    //circulate information of bar establish in chartData
    singleBarSpaceWidth = (xEnd.x - spaceBetweenYandLeft)/[chartData count]; //默认7个数据。
    barWidth = singleBarSpaceWidth*2/3;
    barHeight = origin.y - yEnd.y -9;
    
    [self findMaxAndMinNumberOfData];
}

- (void)setAngelOfShadow:(double)angleOfShadow
{
    if (angleOfShadow > 0.0 && angleOfShadow < 90.0) {
        _angleOfShadow = angleOfShadow;
    }else{
        NSLog(@"\n------The angel of shadow should be in range (0.0,90.0); \n------Now, the value is 30(default);NSLog from setter of angelOfShadow.");
    }
}


#pragma mark - Calcalate
- (void)findMaxAndMinNumberOfData
{
    maxOfFloatData = -1000.0;
    minOfFloatData = 1000.0;
    for (NSNumber *i in _data) {
        if ( maxOfFloatData < i.floatValue) {
            maxOfFloatData = i.floatValue;
        }else if(minOfFloatData > i .floatValue){
            minOfFloatData = i.floatValue;
        }
    }
    
    if ( (maxOfFloatData - (int)maxOfFloatData) == 0) {
        maxOfIntData = (int)maxOfFloatData;
    }else{
        maxOfIntData = (int)maxOfFloatData + 1;
    }
}

#pragma mark - Draw
- (void)drawRect:(CGRect)rect
{
    if ([_data count] > 0) {
        [self drawAxis];
        [self drawGridding];
        [self drawLabel];
    }
}

- (void)drawLabel
{
    [self drawXLabel];
    [self drawYLabel];
    [self drawTitleLabel];
}

- (void)drawXLabel
{
    if (!_showsXLabel) {
        return;
    }
    
    if (!_xLabelString || [_xLabelString count]!=[_data count]) {
        return;
    }
    
    
    for (NSInteger i = 0 ; i < [_data count]; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(
                                                                  spaceBetweenYandLeft + i * singleBarSpaceWidth,
                                                                  origin.y,
                                                                  singleBarSpaceWidth,
                                                                  spaceBetweenXandBottom)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _xLabelString[i];
        label.textColor = _colorOfXYLabel;
        label.backgroundColor = [UIColor clearColor];
        NSInteger fountSize = 4 +  singleBarSpaceWidth/( label.text.length > 1 ? label.text.length : 2 );
        label.font = [UIFont systemFontOfSize:fountSize < 17 ? fountSize:16];
        [self addSubview:label];
    }
}

- (void)drawYLabel
{
    for (int i = 0; i<5; ++i) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, origin.y - 10 - barHeight*i/4, spaceBetweenYandLeft*9/10, 20)];
        label.text =  [NSString stringWithFormat:@"%d",(int)maxOfIntData*i/4];
        label.textColor = _colorOfXYLabel;
        label.backgroundColor = self.backgroundColor;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
    }    
}

- (void)drawTitleLabel
{
    if (!_title) {
        return;
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.text = _title;
    label.textColor = _colorOfTitle;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.0
                                                                         constant:0];
    NSDictionary *metrics = @{@"height":@(origin.y - barHeight)};
    NSDictionary *views = @{@"label":label};
    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label(==height)]"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:views];
    [self addConstraint:centerConstraint];
    [self addConstraints:heightConstraints];
}

- (void)drawAxis
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGFloat* colors = CGColorGetComponents(_colorOfAxis.CGColor);
    CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, xEnd.x, xEnd.y);
    CGPathAddLineToPoint(path, NULL, origin.x, origin.y);
    CGPathAddLineToPoint(path, NULL, yEnd.x, yEnd.y);
    
    CGContextAddPath(context, path);
    
    CGContextStrokePath(context);
    CGPathRelease(path);
}

- (void)drawGridding
{
    if (!_showsGridding) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGFloat* colors = CGColorGetComponents(_colorOfGridding.CGColor);
    CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);

    for (NSInteger i = 1; i<5 ; ++i) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, origin.x, origin.y - barHeight*i/4);
        CGPathAddLineToPoint(path, NULL, xEnd.x, origin.y - barHeight*i/4);
        
        CGContextAddPath(context, path);
        CGContextStrokePath(context);
        CGPathRelease(path);
    }

    
}

-(void)strokeChart
{
    if (_drawsBarChart) {
        [self drawBarInChart];
    }
    
    if (_drawsLineChart) {
        [self drawLineInChart];
    }

}

- (void)drawBarInChart
{
    for (NSInteger i = 0; i < [_data count]; ++i) {
        float percentage = [_data[i] floatValue] / maxOfIntData;
        
        WHChartBar *bar = [[WHChartBar alloc]initWithFrame:CGRectMake(
                                                                      spaceBetweenYandLeft + i * singleBarSpaceWidth +(singleBarSpaceWidth-barWidth)/2,
                                                                      origin.y - barHeight ,
                                                                      barWidth,
                                                                      barHeight)];
        bar.labelValue = [_data[i] floatValue];
        bar.backgroundColorOfChart = self.backgroundColor;
        bar.colorOfBar = _colorOfBar;
        bar.colorOfUnusedPart = _colorOfUnusedPartOfBar;
        bar.animationDuration = _animationDurationOfBar;
        bar.percentage = percentage;
        
        if (_showsShadowOfBar) {
            [self drawShadowOfBar:bar];
        }
        
        [self addSubview:bar];
        
    }
}

- (void)drawShadowOfBar:(WHChartBar *)bar
{
    
    double widthOfShadow = barHeight * bar.percentage * tan(_angleOfShadow/180 * M_PI);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width - 0.4,  bar.frame.origin.y+barHeight*(1-bar.percentage))];
    [path addLineToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width -0.4,   origin.y)];
    [path addLineToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width + widthOfShadow - 0.4,   origin.y)];
    [path addLineToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width - 0.4,  bar.frame.origin.y+barHeight*(1-bar.percentage))];
    
    CAShapeLayer *shadow = [CAShapeLayer layer];
    shadow.lineCap = kCALineCapSquare;
    shadow.fillColor = _colorOfShadow.CGColor;
    shadow.path = path.CGPath;
    shadow.bounds = CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height);
    shadow.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    shadow.masksToBounds = YES;
    
    UIBezierPath *tempPath = [UIBezierPath bezierPath];
    [tempPath moveToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width - 0.4,  origin.y)];
    [tempPath addLineToPoint:CGPointMake(bar.frame.origin.x+bar.frame.size.width -0.4,   origin.y)];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = _animationDurationOfBar;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = (__bridge id)((tempPath.CGPath));
    pathAnimation.toValue = (__bridge id)((path.CGPath));
    pathAnimation.autoreverses = NO;
    [shadow addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    [self.layer addSublayer:shadow];
}

- (void)drawLineInChart
{
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapRound;
    chartLine.lineJoin = kCALineJoinBevel;
    chartLine.fillColor   = [[UIColor clearColor] CGColor];
    chartLine.lineWidth  = _lineWidth;
    chartLine.strokeEnd  = 0.0;
    chartLine.strokeColor = _colorOfLine.CGColor;
    [self.layer addSublayer:chartLine];
    
    if (_showsGradientColor) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [gradientLayer setColors:_gradientColors];
        [gradientLayer setLocations:_gradientLocations];
        [gradientLayer setStartPoint:_gradientStartPoint];
        [gradientLayer setEndPoint:_gradientEndPoint];
        [gradientLayer setMask:chartLine];
        [self.layer addSublayer:gradientLayer];
    }
    
    chartLine.path = [self getBezierPathWithSmooth:_smoothesLine].CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _animationDurationOfLine;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    chartLine.strokeEnd = 1.0;
}

- (UIBezierPath *)getBezierPathWithSmooth:(BOOL)smooth{
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline setLineWidth:_lineWidth];
    [progressline setLineCapStyle:kCGLineCapRound];
    [progressline setLineJoinStyle:kCGLineJoinRound];
    
    [progressline moveToPoint:[self getPointForIndex:0]];
    
    if (smooth) {
        
        for (NSInteger i = 1 ; i < [_data count]; ++i) {
        
            CGPoint currentPoint = [self getPointForIndex:i];
            CGPoint prev1Point = [self getPointForIndex:i-1];
            CGPoint prev2Point = [self getPointForIndex:i-2];
            CGPoint nextPoint = [self getPointForIndex:i+1];
            CGPoint distance;
      
            if(i == 1){
                distance.x = (currentPoint.x - prev1Point.x)/2;
                distance.y = (currentPoint.y - prev1Point.y)/2;
            }else{
                distance.x = (currentPoint.x - prev2Point.x)/2;
                distance.y = (currentPoint.y - prev2Point.y)/2;
            }
            
            CGPoint controlPoint1;
            controlPoint1.x = prev1Point.x + distance.x * _kOfBezierPath;
            controlPoint1.y = prev1Point.y + distance.y * _kOfBezierPath;
      
            if (i == _data.count - 1) {
                distance.x = (currentPoint.x - prev1Point.x)/2;
                distance.y = (currentPoint.y - prev1Point.y)/2;
            }else{
                distance.x = (nextPoint.x - prev1Point.x)/2;
                distance.y = (nextPoint.y - prev1Point.y)/2;
            }
            
            CGPoint controlPoint2;
            controlPoint2.x = currentPoint.x - distance.x * _kOfBezierPath;
            controlPoint2.y = currentPoint.y - distance.y * _kOfBezierPath;

            [progressline addCurveToPoint:currentPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        }
    
    }else{
            for (NSInteger i = 1; i < [_data count]; ++i) {
                
                float percentage = [_data[i] floatValue] / maxOfIntData;
                [progressline addLineToPoint:CGPointMake(spaceBetweenYandLeft + singleBarSpaceWidth * (i) +singleBarSpaceWidth/2, origin.y - barHeight* percentage)];
            }
    }
    
    return progressline;
}

- (CGPoint)getPointForIndex:(NSInteger)index
{
    if (index < 0 || index >= _data.count) {
        return CGPointZero;
    }
    
    float percentage = [_data[index] floatValue] / maxOfIntData;
    CGPoint point = CGPointMake(spaceBetweenYandLeft + singleBarSpaceWidth * (index) +singleBarSpaceWidth/2, origin.y - barHeight* percentage);

    return point;
}










@end
