//
//  ColorView.m
//  JS_OC_Demo
//
//  Created by Nemo on 2016/11/26.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ColorView.h"
#import "ShowColorView.h"

@interface ColorView ()<ShowColorViewDelegate>

@property (nonatomic,strong) ShowColorView *colorView;

@property (nonatomic,strong) UIView *showView;

@end

@implementation ColorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
        
        _showView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _showView.backgroundColor  = [UIColor blackColor];
        [self addSubview:_showView];
        CGFloat x = 10;
        CGFloat y = 5;
        _colorView = [[ShowColorView alloc] initWithFrame: CGRectMake(CGRectGetMaxX(_showView.frame)+5, 5, frame.size.width-CGRectGetMaxX(_showView.frame)-x, frame.size.height-2*y)];
        _colorView.delegate = self;
        [self addSubview:_colorView];
        
    }
    return self;
}

-(void)selectColorActionWith:(UIColor *)color
{
    _showView.backgroundColor = color;
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
