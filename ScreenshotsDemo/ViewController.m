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
#import "TestViewController.h"

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
    
    tv =[[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageV.frame)+30, rect.size.width-20, 30)];
    
    NSString *name = @"[10].png";
    
    TextAttachment *ment = [[TextAttachment alloc] init];
    
    ment.image = [UIImage imageNamed:name];
    ment.size = CGSizeMake(20, 20);
    [tv.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:ment] atIndex:tv.selectedRange.location];
    tv.selectedRange = NSMakeRange(tv.selectedRange.location + 1, tv.selectedRange.length);
    
    [self.view addSubview:tv];
    
    [self createRight];
}

-(void)createRight{

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:UIBarButtonItemStyleDone target:self action:@selector(screenShots)];
    self.navigationItem.rightBarButtonItem = item;

}
-(void)screenShots{

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
    view.saveImage = YES;
    [self.view addSubview:view];

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
    
    TestViewController *test = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:test animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
