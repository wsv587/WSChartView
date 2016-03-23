//
//  WHChartBar.h
//  WHChartView
//
//  Created by 王振辉 on 15/8/15.
//  Copyright (c) 2015年 王振辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHChartBar : UIView

@property (nonatomic, strong)   UIColor *backgroundColorOfChart;
@property (nonatomic, strong)   UIColor *colorOfBar;
@property (nonatomic, strong)   UIColor *colorOfUnusedPart;

@property (nonatomic, strong)   CAShapeLayer *bar;
@property (nonatomic)           float percentage; //      percentage = (bar's height) / (self.view's height)
@property (nonatomic)           float labelValue;
@property (nonatomic)           CFTimeInterval animationDuration;

@end
