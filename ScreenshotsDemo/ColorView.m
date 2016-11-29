//
//  ColorView.m
//  JS_OC_Demo
//
//  Created by Nemo on 2016/11/26.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        
        //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
        [self.layer addSublayer:gradientLayer];
        
        //设置渐变区域的起始和终止位置（范围为0-1）
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        
        //设置颜色数组
        gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor lightGrayColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor,
                                      (__bridge id)[UIColor blackColor].CGColor];
        
        //设置颜色分割点（范围：0-1）

        gradientLayer.locations = @[@(0.25f), @(0.5f),@(0.75f),@(1.0f)];
    }
    return self;
}

//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//
//    CGFloat r = 0;
//    CGFloat g = 0;
//    CGFloat b = 0;
//    CGFloat colorWidth = self.frame.size.width/12;
//    for (int j = 0 ; j < 12; j ++) {
//        
//        CGPoint first = [points[j] CGPointValue];
//        CGPoint second = [points[j+1] CGPointValue];
//        
//        CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 1);
//        CGContextSetLineWidth(context,self.frame.size.height);
//        
//        CGContextSetLineCap(context, kCGLineCapRound);
//        
//        CGContextMoveToPoint(context, first.x, first.y);
//        CGContextAddLineToPoint(context, second.x,second.y);
//        CGContextStrokePath(context);
//    }
//    
//}

@end
