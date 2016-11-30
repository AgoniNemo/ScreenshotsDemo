//
//  ViewController.m
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"
#import "DrawRectView.h"
#import "ColorView.h"
#import "TextAttachment.h"

@interface ViewController ()
{
    UITextView *tv;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"pic_029.jpg"];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    imageV.frame = CGRectMake(10, 100, image.size.width, image.size.height);
    [self.view addSubview:imageV];
    
    
    CGRect rect = [UIScreen mainScreen].bounds;
    ColorView *v = [[ColorView alloc] initWithFrame:CGRectMake(10, 300, rect.size.width-20, 30)];
    
    [self.view addSubview:v];
    
    tv =[[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(v.frame)+30, rect.size.width-20, 30)];
    
    NSString *name = @"[10].png";
    
    TextAttachment *ment = [[TextAttachment alloc] init];
    
    ment.image = [UIImage imageNamed:name];
    ment.size = CGSizeMake(20, 20);
    [tv.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:ment] atIndex:tv.selectedRange.location];
    tv.selectedRange = NSMakeRange(tv.selectedRange.location + 1, tv.selectedRange.length);
    
    [self.view addSubview:tv];
    
}
//根据字体计算表情的高度
- (CGFloat)heightWithFont:(UIFont *)font {
    
    if (!font){font = [UIFont systemFontOfSize:17];}
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGSize maxsize = CGSizeMake(100, MAXFLOAT);
    
    CGSize size = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSString *name = @"[10].png";
    
    TextAttachment *ment = [[TextAttachment alloc] init];
    
    ment.image = [UIImage imageNamed:name];
    ment.size = CGSizeMake(20, 20);
    [tv.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:ment] atIndex:tv.selectedRange.location];
    tv.selectedRange = NSMakeRange(tv.selectedRange.location + 1, tv.selectedRange.length);
    
    /**
    UIWindow *screenWindow = [[UIApplication sharedApplication].windows lastObject];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(viewImage,nil,nil,nil);
    
    DrawRectView *view = [[DrawRectView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    view.image = viewImage;
    view.isBezier = NO;
    [self.view addSubview:view];
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
