//
//  BottomControlView.m
//  XingLiIM
//
//  Created by Mjwon on 2017/3/30.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "BottomControlView.h"

@implementation BottomControlView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7f];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(0, 0);//坐标1
    aPoints[1] =CGPointMake(self.bounds.size.width, 0);//坐标2
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:143/255.0 green:136/255.0 blue:140/255.0 alpha:1].CGColor);
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
}

@end
