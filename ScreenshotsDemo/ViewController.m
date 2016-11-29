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
@interface ViewController ()

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
    ColorView *v = [[ColorView alloc] initWithFrame:CGRectMake(10, 300, rect.size.width-20, 20)];
    
    [self.view addSubview:v];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
