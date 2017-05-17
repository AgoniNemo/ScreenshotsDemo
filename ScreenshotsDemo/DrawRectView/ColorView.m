//
//  ColorView.m
//  JS_OC_Demo
//
//  Created by Nemo on 2016/11/26.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ColorView.h"

@interface ColorView ()

@property (nonatomic ,strong) NSMutableArray *rects;
@property (nonatomic ,strong) NSMutableArray *colors;
@end

@implementation ColorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.4f];
        _rects = [NSMutableArray array];
       _colors = [NSMutableArray array];
        
        NSArray *rs = @[@255,@253,@254,@255,@0,@33,@0,@143,@248];
        NSArray *gs = @[@255,@0,@183,@230,@174,@206,@55,@81,@28];
        NSArray *bs = @[@252,@0,@65,@0,@0,@255,@195,@255,@192];
        
        for (int i = 0 ; i < rs.count; i ++) {
            UIColor *color = [UIColor colorWithRed:[rs[i] integerValue]/255.0 green:[gs[i] integerValue]/255.0 blue:[bs[i] integerValue]/255.0 alpha:1];
            [_colors addObject:color];;
        }
        UIImage *image = [UIImage imageNamed:@"painting_back"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(frame.size.width-image.size.width-15, 11, image.size.width+15, image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        NSLog(@"btn:%@",NSStringFromCGRect(btn.frame));
        
        [btn setImage:image forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
-(void)btnAction{

    if (self.returnPrevious) {
        self.returnPrevious();
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    for (int i = 0 ; i < _rects.count; i ++) {
        NSValue *value = _rects[i];
        if (CGRectContainsPoint([value CGRectValue], touchPoint)) {
            NSLog(@"--%@--",NSStringFromCGPoint(touchPoint));
            if (self.selectColor) {
                self.selectColor(_colors[i]);
            }
        }
    }
    
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat w = (rect.size.width-22-15-11-9)/_colors.count;
    CGFloat colorWidth = (w>32)?32:w;
    CGFloat sq = 1;
    for (int i = 0 ; i < _colors.count; i ++) {
        CGRect r = CGRectMake(11+i*(sq+colorWidth), (rect.size.height-colorWidth)/2, colorWidth, colorWidth);
        //添加矩形
        CGContextAddRect(context,r);
        [_rects addObject:[NSValue valueWithCGRect:r]];
        
        /**
        * 描边的颜色
          CGFloat redColor[4] = {1.0,0.0,0.0,1.0};
          CGContextSetStrokeColor(context, redColor);
         
        */
        
        //填充的颜色
//        CGFloat greenColor[4] = {0.0,1.0,0.0,1.0};
//        CGContextSetFillColor(context, [UIColor redColor].CGColor);
        UIColor *color = _colors[i];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
        //4.绘图
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
}

@end
