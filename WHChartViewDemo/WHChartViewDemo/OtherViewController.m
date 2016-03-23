//
//  OtherViewController.m
//  WHChartViewDemo
//
//  Created by 王振辉 on 15/9/9.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//

#import "OtherViewController.h"
#import "UIColor+WHColor.h"
#import "WHChartView.h"

@interface OtherViewController () {
    WHChartView *chart;
}

@end

@implementation OtherViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[self chart1]];
    [self.view addSubview:[self chart2]];
}

- (WHChartView *)chart1
{
    // WS:创建柱状图整个表格
    chart = [[WHChartView alloc]initWithFrame:CGRectMake(20, 50+16, self.view.bounds.size.width - 40, 200)];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Unused part of bar";
    //chart.colorOfTitle = [UIColor whClouds];              //Using default value;
    //chart.colorOfXYLabel = [UIColor lightGrayColor];      //Using default value;
    //chart.colorOfAxis = [UIColor whClouds];               //Using default value;
    //chart.colorOfGridding = [UIColor whClouds];           //Using default value;
    chart.showsGridding = YES; // 是否显示水平线
    chart.showsXLabel = YES; // 是否显示x轴的标尺
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES; // 是否绘制柱状图 返回NO则不绘制柱状图
    chart.colorOfBar = [UIColor whCarrot]; // 柱状图实体部分的颜色
    chart.colorOfUnusedPartOfBar = [UIColor whSilverWithAlpha:0.8];  // 柱状图虚体部分的颜色
    chart.showsShadowOfBar = NO; // 是否显示阴影
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    //chart.angleOfShadow = 30.0;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = NO; // 是否绘制曲线 也就是类似于k线的曲线 为了反应柱状图的起伏走势
    //chart.lineWidth = 1.0;                                //Using default value;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;                  //Using default value;
    
    chart.smoothesLine = NO; // 绘制的曲线是否平滑过渡 只有在drawsLineChart属性为YES的时候才有效
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = YES; // 是否显示梯度颜色 目前还不知道这个属性是干嘛的？？？
    //chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whGreen].CGColor ,(id)[UIColor whOrange].CGColor,(id)[UIColor whAlizarin].CGColor, nil];                            //Using default value;
    //chart.gradientLocations = @[@0.2,@0.5,@0.9 ];         //Using default value;
    //chart.gradientStartPoint = CGPointMake(0.5, 0);       //Using default value;
    //chart.gradientEndPoint = CGPointMake(0.5, 1);         //Using default value;
    
    [chart setChartData:dataValue];
    [chart strokeChart];
    
    return chart;
}

- (WHChartView *)chart2
{
    chart = [[WHChartView alloc]initWithFrame:CGRectMake(20, 250+16, self.view.bounds.size.width - 40, 200)];
    
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:140];
    for(int i=0;i<50;i++) {
        float r = rand()%100 /100.0  + 2.5 - i/20.0;
        [data addObject:[NSNumber numberWithFloat:r]];
    }
    
    /***  Coordinate ***/
    chart.title = @"Broken line graph";
    //chart.colorOfTitle = [UIColor whClouds];              //Using default value;
    //chart.colorOfXYLabel = [UIColor lightGrayColor];      //Using default value;
    //chart.colorOfAxis = [UIColor whClouds];               //Using default value;
    //chart.colorOfGridding = [UIColor whClouds];           //Using default value;
    chart.showsGridding = YES;
    chart.showsXLabel = NO;
    //chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = NO;
    //chart.colorOfBar = [UIColor whCarrot];
    //chart.colorOfUnusedPartOfBar = [UIColor whSilverWithAlpha:0.8];
    //chart.showsShadowOfBar = NO;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    //chart.angleOfShadow = 30.0;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    chart.lineWidth = 1.0;                                //Using default value;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;                  //Using default value;
    
    chart.smoothesLine = NO;
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = NO;
    //chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whGreen].CGColor ,(id)[UIColor whOrange].CGColor,(id)[UIColor whAlizarin].CGColor, nil];                            //Using default value;
    //chart.gradientLocations = @[@0.2,@0.5,@0.9 ];         //Using default value;
    //chart.gradientStartPoint = CGPointMake(0.5, 0);       //Using default value;
    //chart.gradientEndPoint = CGPointMake(0.5, 1);         //Using default value;
    
    [chart setChartData:data];
    [chart strokeChart];
    
    return chart;
}

@end
