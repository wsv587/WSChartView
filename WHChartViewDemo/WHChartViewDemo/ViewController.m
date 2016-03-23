//
//  ViewController.m
//  WHChartViewDemo
//
//  Created by 王振辉 on 15/8/25.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//

#import "ViewController.h"
#import "WHChartView.h"
#import "UIColor+WHColor.h"
#import "OtherViewController.h"

@interface ViewController (){
    WHChartView *chart;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[self chart1]];
    [self.view addSubview:[self chart2]];
    [self.view addSubview:[self chart3]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Other" style:UIBarButtonItemStyleDone target:self action:@selector(pushPage)];
    item.title = @"other";
    self.navigationItem.rightBarButtonItem = item;
}

- (void)pushPage {
    OtherViewController *viewController = [[OtherViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (WHChartView *)chart1
{
    chart = [[WHChartView alloc]initWithFrame:CGRectMake(20, 50+16, self.view.bounds.size.width - 40, 200)];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Bar and Line";
    //chart.colorOfTitle = [UIColor whClouds];              //Using default value;
    //chart.colorOfXYLabel = [UIColor lightGrayColor];      //Using default value;
    //chart.colorOfAxis = [UIColor whClouds];               //Using default value;
    //chart.colorOfGridding = [UIColor whClouds];           //Using default value;
    chart.showsGridding = YES;
    chart.showsXLabel = YES;
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES;
    chart.colorOfBar = [UIColor whAsbestos];
    chart.colorOfUnusedPartOfBar = [UIColor clearColor];
    chart.showsShadowOfBar = NO;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    //chart.angleOfShadow = 30.0;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    //chart.lineWidth = 1.0;                                //Using default value;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;                  //Using default value;
    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = YES;
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
    for(int i=0;i<140;i++) {
        float r = rand()%100 /100.0  + 7.0 - i/20.0;
        [data addObject:[NSNumber numberWithFloat:r]];
    }
    
    
    /***  Coordinate ***/
    chart.title = @"Line Only";
    //chart.colorOfTitle = [UIColor whClouds];              //Using default value;
    //chart.colorOfXYLabel = [UIColor lightGrayColor];      //Using default value;
    //chart.colorOfAxis = [UIColor whClouds];               //Using default value;
    //chart.colorOfGridding = [UIColor whClouds];           //Using default value;
    chart.showsGridding = YES;
    chart.showsXLabel = NO;
    //chart.xLabelString = nil;                             //Using default value;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = NO;
    //chart.colorOfBar = [UIColor whAsbestos];
    //chart.colorOfUnusedPartOfBar = [UIColor clearColor];
    //chart.showsShadowOfBar = NO;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];
    //chart.angleOfShadow = 30.0;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = YES;
    chart.lineWidth = 1.0;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;                  //Using default value;
    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = YES;
    chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whAlizarin].CGColor ,(id)[UIColor whCarrot].CGColor,(id)[UIColor whLightBlue].CGColor, nil];
    //chart.gradientLocations = @[@0.2,@0.5,@0.9 ];         //Using default value;
    //chart.gradientStartPoint = CGPointMake(0.5, 0);       //Using default value;
    //chart.gradientEndPoint = CGPointMake(0.5, 1);         //Using default value;
    
    [chart setChartData:data];
    [chart strokeChart];
    
    return chart;
}

- (WHChartView *)chart3
{
    chart = [[WHChartView alloc]initWithFrame:CGRectMake(20, 450+16, self.view.bounds.size.width - 40, 200)];
    
    NSArray *dataValue = @[@123.5,@122,@87,@101.1,@16,@60.6,@51,@44,@20,@18,@98,@110,@19,@77];
    NSArray *xLabelString = @[@"6-10",@"6-11",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17",@"6-12",@"6-13",@"6-14",@"6-15",@"6-16",@"6-17"];
    
    /***  Coordinate ***/
    chart.title = @"Bar only";
    //chart.colorOfTitle = [UIColor whClouds];              //Using default value;
    //chart.colorOfXYLabel = [UIColor lightGrayColor];      //Using default value;
    //chart.colorOfAxis = [UIColor whClouds];               //Using default value;
    //chart.colorOfGridding = [UIColor whClouds];           //Using default value;
    chart.showsGridding = YES;
    chart.showsXLabel = YES;
    chart.xLabelString = xLabelString;
    
    /***  Bar in Chart ***/
    chart.drawsBarChart = YES;
    chart.colorOfBar = [UIColor whLightBlue];
    chart.colorOfUnusedPartOfBar = [UIColor clearColor];
    chart.showsShadowOfBar = YES;
    //chart.colorOfShadow = [UIColor colorWithRed:0.35 green:0.45 blue:0.55 alpha:0.9];         //Using default value;
    //chart.angleOfShadow = 30.0;                           //Using default value;
    //chart.animationDurationOfBar = 1.5;                   //Using default value;
    
    /***  Line in Chart ***/
    chart.drawsLineChart = NO;
    //chart.lineWidth = 1.0;                                //Using default value;
    //chart.colorOfLine = [UIColor blackColor];
    //chart.animationDurationOfLine = 1.5;                  //Using default value;
    
    chart.smoothesLine = YES;
    //chart.kOfBezierPath = 0.25;                           //Using default value;
    chart.showsGradientColor = YES;
    //chart.gradientColors = [NSArray arrayWithObjects:(id)[UIColor whGreen].CGColor ,(id)[UIColor whOrange].CGColor,(id)[UIColor whAlizarin].CGColor, nil];                            //Using default value;
    //chart.gradientLocations = @[@0.2,@0.5,@0.9 ];         //Using default value;
    //chart.gradientStartPoint = CGPointMake(0.5, 0);       //Using default value;
    //chart.gradientEndPoint = CGPointMake(0.5, 1);         //Using default value;
    
    
    [chart setChartData:dataValue];
    [chart strokeChart];
    
    return chart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

