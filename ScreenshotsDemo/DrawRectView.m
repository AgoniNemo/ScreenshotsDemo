//
//  DrawRectView.m
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "DrawRectView.h"
#import "DrawModel.h"
#import "ColorView.h"

@interface DrawRectView ()
{
    CGContextRef context;
    BOOL show;
}
@property (nonatomic ,assign) NSInteger indext;
@property (nonatomic ,strong) NSMutableArray *paths;
@property (nonatomic ,strong) UIBezierPath *path;
@property (nonatomic ,strong) NSMutableArray *oldPaths;
@property (nonatomic ,strong) ColorView *slectColorView;
@end

@implementation DrawRectView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        show = YES;
        _paths = [NSMutableArray array];
        CGFloat height = 40;
        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,frame.size.height-height, frame.size.width, height)];
        
        UIBarButtonItem *i1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
        
        UIBarButtonItem *i2 = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(load)];
        
        UIBarButtonItem *i3 = [[UIBarButtonItem alloc] initWithTitle:@"删除所有" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAll)];
        
        UIBarButtonItem *i4 = [[UIBarButtonItem alloc] initWithTitle:@"设置颜色" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
        UIBarButtonItem *i5 = [[UIBarButtonItem alloc] initWithTitle:@"保存图片" style:UIBarButtonItemStyleDone target:self action:@selector(savaImage)];
        bar.items = @[i1,i2,i3,i4,i5];
        bar.barTintColor = [UIColor colorWithRed:87/255.0 green:136/255.0 blue:170/255.0 alpha:1];
        bar.tintColor = [UIColor whiteColor];
        [self addSubview:bar];
        
    }
    return self;
}
-(void)pan:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.path = [UIBezierPath bezierPath];
        [self.paths addObject:self.path];
        [self.path moveToPoint:point];
    }else if(sender.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:point];
        [self.paths addObject:self.path];
        [self setNeedsDisplay];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if (_isBezier) {
        DrawBezierModel *model = [[DrawBezierModel alloc] init];
        model.lineWidth = self.lineWidth?:5;
        model.color = self.color?:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        model.path = [UIBezierPath bezierPath];
        [self.paths addObject:model];
        [model.path moveToPoint:touchPoint];
    }else{
        DrawSubModel *model = [[DrawSubModel alloc] init];
        model.lineWidth = self.lineWidth?:5;
        model.color = self.color?:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1];
        NSValue *value = [NSValue valueWithCGPoint:touchPoint];
        model.paths = [NSMutableArray arrayWithObject:value];
        [_paths addObject:model];
    }
    self.oldPaths = [_paths mutableCopy];
    NSLog(@"touchesBegan:%@",NSStringFromCGPoint(touchPoint));
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if (_isBezier) {
        DrawBezierModel *model = [_paths lastObject];
        [model.path addLineToPoint:touchPoint];
        [self.paths addObject:model];
        
    }else{
        NSValue *value = [NSValue valueWithCGPoint:touchPoint];
        DrawSubModel *model = [_paths lastObject];
        [model.paths addObject:value];
        
    }
    
    [self setNeedsDisplay];
}
-(void)load{
    
    if (self.oldPaths.count > _paths.count) {
        [_paths addObject:self.oldPaths[_paths.count]];
        [self setNeedsDisplay];
    }
}
-(void)cancel{
    
    [_paths removeLastObject];
    NSLog(@"%@---%@",self.paths,self.oldPaths);
    
    [self setNeedsDisplay];
}
-(void)deleteAll{
    [_paths removeAllObjects];
    [self setNeedsDisplay];
}
-(void)setting{
    
    [self addSubview:self.slectColorView];
    show = !show;
    self.slectColorView.hidden = show;
    
    __weak typeof(self) ws = self;
    self.slectColorView.selectColor = ^(UIColor *color){
        ws.color = color;
    };
}

-(void)savaImage{

    NSLog(@"保存图片！");
    UIImage *image = [self getImage];
    if (!_saveImage) {
        [self setDelegateForImage:image];
        return;
    }
    __weak typeof(self) ws = self;
    if (_delegate && [_delegate respondsToSelector:@selector(selectImageView:)]) {
        [_delegate selectImageView:image];
    }
    dispatch_async(dispatch_queue_create("save.image.com", NULL), ^{
        UIImageWriteToSavedPhotosAlbum(image,ws,@selector(image:didFinishSavingWithError:contextInfo:),(__bridge void *)ws);
    });
}
-(UIImage *)getImage{

    UIGraphicsBeginImageContext(self.bounds.size);
    
    //renderInContext（其参数的子图层也会被绘制进来）
    [self.layer drawInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}
-(void)setDelegateForImage:(UIImage *)image{

    if (_delegate && [_delegate respondsToSelector:@selector(selectImageView:)]) {
        [_delegate selectImageView:image];
    }
    [self removeFromSuperview];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    [self removeFromSuperview];
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

-(void)drawRect:(CGRect)rect
{
    context = UIGraphicsGetCurrentContext();
    
    /** 画出来的图片是倒的，坐标不同
    CGContextDrawImage(context, self.bounds, _image.CGImage);
     */
    [_image drawInRect:self.bounds];//在坐标中画出图片
    
    if (_isBezier) {
        for (DrawBezierModel *model in self.paths) {
            [model.path setLineWidth:model.lineWidth];
            UIColor *color = model.color;
            [color set];
            [model.path stroke];
        }
        return;
    }
    
    for (int i = 0; i < _paths.count; i ++) {
        
        DrawSubModel *model = _paths[i];
        NSMutableArray *points = model.paths;
        for (int j = 0 ; j < points.count-1; j ++) {

            CGPoint first = [points[j] CGPointValue];
            CGPoint second = [points[j+1] CGPointValue];
            /**
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 1);*/
            CGContextSetStrokeColorWithColor(context, model.color.CGColor);
            CGContextSetLineWidth(context,model.lineWidth);
            
            CGContextSetLineCap(context, kCGLineCapRound);
            
            CGContextMoveToPoint(context, first.x, first.y);
            CGContextAddLineToPoint(context, second.x,second.y);
            CGContextStrokePath(context);
        }
        
    }
}
-(ColorView *)slectColorView
{
    if (_slectColorView == nil) {
        _slectColorView = [[ColorView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-80, self.bounds.size.width-20, 30)];
    }
    return _slectColorView;
}

@end
