//
//  WHChartBar.m
//  WHChartView
//
//  Created by 王振辉 on 15/8/15.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//

#import "WHChartBar.h"
#import "UIColor+WHColor.h"
@interface WHChartBar (){
    BOOL    labelHasShown;
    UILabel *label;
}
@end

@implementation WHChartBar

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //_backgroundColorofBar = [UIColor clearColor];
        
        self.backgroundColor = [UIColor clearColor];
        _colorOfBar = [UIColor whLightBlue];
        _colorOfUnusedPart = [UIColor clearColor];
        _animationDuration = 1.5;
        
        _bar = [CAShapeLayer layer];
        _bar.lineWidth = self.frame.size.width;
        _bar.strokeEnd = 0.0;
        _bar.strokeColor = _colorOfBar.CGColor;
        labelHasShown = NO;
        
        self.clipsToBounds = YES;
        [self.layer addSublayer:_bar];
        self.layer.cornerRadius = 2.0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped:)];
        
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

#pragma mark - Action
- (void)labelTapped:(id)sender{ // 点击柱状图，显示value；再次点击，隐藏value
    if (!labelHasShown) {
        label = [[UILabel alloc]init];
        UIColor *labelBackGroundColor = [_backgroundColorOfChart colorWithAlphaComponent:0.7];
        
        label.backgroundColor =
                                (_percentage >= (self.frame.size.height - self.frame.size.width)/self.frame.size.height) ?
                                [UIColor clearColor]:labelBackGroundColor;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = [NSString stringWithFormat:@"%d",(int)_labelValue];

        CGFloat fountSize = (self.frame.size.width / label.text.length) * 2 - 3;
        label.font = [UIFont systemFontOfSize: (fountSize > 14) ? 13:fountSize];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        [self SetAutoLayoutOfLabelAndSelf];

        labelHasShown = YES;
    }else{
        [label removeFromSuperview];
        labelHasShown = NO;
    }
}

#pragma mark - AutoLayout
- (void)SetAutoLayoutOfLabelAndSelf
{
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0
                                                                        constant:0];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationLessThanOrEqual
                                                                           toItem:label
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1.0
                                                                         constant:0];
    
    NSNumber *number = [NSNumber numberWithDouble:
                        (_percentage >= (self.frame.size.height - self.frame.size.width)/self.frame.size.height) ?
                        (self.frame.size.height - label.font.lineHeight):(self.frame.size.height*_percentage )];
    
    NSDictionary *metrics = @{@"height":number};
    NSDictionary *views = @{@"label":label};
    
    NSArray *topConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-height-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    NSArray *leftConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views];
    
    [self addConstraint:widthConstraint];
    [self addConstraint:heightConstraint];
    [self addConstraints:topConstraints];
    [self addConstraints:leftConstraint];
}

#pragma mark - Draw
- (void)drawRect:(CGRect)rect
{
    //Draw Background
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _colorOfUnusedPart.CGColor);
    CGContextFillRect(context, rect);
    
}

- (void)setPercentage:(float)percentage
{
    if (!percentage) {
        return;
    }
    _bar.strokeColor = _colorOfBar.CGColor;
    _percentage = percentage;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:1.0];
    [path setLineCapStyle:kCGLineCapSquare];
    [path moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1.0 - percentage) * self.frame.size.height)];
    _bar.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _animationDuration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue =[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_bar addAnimation:pathAnimation forKey:@"strokeAnimation"];
    
    _bar.strokeEnd = 1.0;
    
}


@end
