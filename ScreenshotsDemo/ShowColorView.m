//
//  ShowColorView.m
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/30.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ShowColorView.h"

#define TOTAL 255*3

@implementation ShowColorView

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
        
        gradientLayer.locations = @[@(0.25f),@(0.3f), @(0.5f),@(0.75f),@(1.0f)];

        
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if ([_delegate respondsToSelector:@selector(selectColorActionWith:)]) {
        [_delegate selectColorActionWith:[self computeRGBValueWithPoint:point.x]];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    if ([_delegate respondsToSelector:@selector(selectColorActionWith:)]) {
        [_delegate selectColorActionWith:[self computeRGBValueWithPoint:point.x]];
    }
}

-(UIColor *)computeRGBValueWithPoint:(CGFloat)point{

    if (point < 0) {
        point += self.frame.size.width;
    }
    
    NSInteger t = floor(TOTAL*point/self.frame.size.width);
    
    CGFloat total = TOTAL*point/self.frame.size.width;
    CGFloat decimal = total-t;
    CGFloat r = 0.0f;
    CGFloat g = 0.0f;
    CGFloat b = 0.0f;
    
    NSInteger conut = total/255;
    NSLog(@"%f",point);
    NSLog(@"%ld",conut);
    switch (conut) {
        case 0:
        {
            r = total;
        }
            break;
        case 1:
        {
            r = 255;
            g = total - 255 + decimal;
        }
            break;
        case 2:
        {
            r = 255;
            g = 255;
            b = total - 2*255 + decimal;
        }
            break;
        case 3:
        {
            r = 255;
            g = 255;
            b = 255;
        }
            break;
            
        default:
            break;
    }
    
    
    UIColor *color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];

    
    return color;
}

@end
