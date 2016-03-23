//
//  WHChart.h
//  WHChartView
//
//  Created by 王振辉 on 15/8/15.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHChartView : UIView

/***  Coordinate ***/
@property (nonatomic, copy)     NSString *title;
@property (nonatomic, strong)   UIColor *colorOfTitle;
@property (nonatomic, strong)   UIColor *colorOfXYLabel;
@property (nonatomic, strong)   UIColor *colorOfAxis;
@property (nonatomic, strong)   UIColor *colorOfGridding;
@property (nonatomic)           BOOL showsGridding;
@property (nonatomic)           BOOL showsXLabel;
@property (nonatomic, strong)   NSArray *xLabelString;  //Data of XLabel


/***  Bar in Chart ***/
@property (nonatomic)           BOOL drawsBarChart;
@property (nonatomic, strong)   UIColor *colorOfBar;
@property (nonatomic, strong)   UIColor *colorOfUnusedPartOfBar;
@property (nonatomic)           BOOL showsShadowOfBar;
@property (nonatomic, strong)   UIColor *colorOfShadow;
@property (nonatomic)           double angleOfShadow;
@property (nonatomic)           CFTimeInterval animationDurationOfBar; //animationDuration


/***  Line in Chart ***/
@property (nonatomic)           BOOL drawsLineChart;
@property (nonatomic)           CGFloat lineWidth;
@property (nonatomic, strong)   UIColor *colorOfLine;
@property (nonatomic)           CFTimeInterval animationDurationOfLine;

@property (nonatomic)           BOOL smoothesLine;        //BazierPath
@property (nonatomic)           CGFloat kOfBezierPath;

@property (nonatomic)           BOOL showsGradientColor; //GradientColor
@property (nonatomic, strong)   NSArray *gradientColors;
@property (nonatomic, strong)   NSArray *gradientLocations;
@property (nonatomic)           CGPoint gradientStartPoint;
@property (nonatomic)           CGPoint gradientEndPoint;

- (void)setChartData:(NSArray *)chartData;
- (void)strokeChart;

@end
