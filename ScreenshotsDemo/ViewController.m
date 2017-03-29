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
#import "ILHuePickerView.h"

@interface ViewController ()<DrawRectViewDelegate,ILHuePickerViewDelegate>
{
    UITextView *tv;
}
@property (nonatomic ,strong) UIImage *image;
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
    
    tv =[[UITextView alloc] initWithFrame:CGRectMake(10, rect.size.height-30, rect.size.width-20, 30)];
    
    NSString *name = @"[10].png";
    
    TextAttachment *ment = [[TextAttachment alloc] init];
    
    ment.image = [UIImage imageNamed:name];
    ment.size = CGSizeMake(20, 20);
    [tv.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:ment] atIndex:tv.selectedRange.location];
    tv.selectedRange = NSMakeRange(tv.selectedRange.location + 1, tv.selectedRange.length);
    
    [self.view addSubview:tv];
    
    [self createRight];
    
//    [self createView];
}

-(void)createView{

    CGRect rect = [UIScreen mainScreen].bounds;
    ILHuePickerView *color = [[ILHuePickerView alloc] initWithFrame:CGRectMake(10, 100, rect.size.width-20, 40)];
    color.delegate = self;
    [self.view addSubview:color];

}
-(void)huePicked:(float)hue picker:(ILHuePickerView *)picker{

    self.view.backgroundColor = picker.color;
}
-(void)createRight{

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStyleDone target:self action:@selector(screenShots)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"leftItem" style:UIBarButtonItemStyleDone target:self action:@selector(skipNext)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenShots)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    swipe.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:swipe];

}
-(void)screenShots{

    UIWindow *screenWindow = [[UIApplication sharedApplication].windows lastObject];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    
    [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSLog(@"viewImage:%@",viewImage);
     _image = viewImage;
    DrawRectView *view = [[DrawRectView alloc] initWithFrame:self.view.bounds];
    view.image = viewImage;
    view.isBezier = NO;
    view.delegate = self;
    view.saveImage = YES;
    view.color = [UIColor blackColor];
    [screenWindow addSubview:view];

}
-(void)skipNext{
    TestViewController *test = [[TestViewController alloc] init];
    test.image = _image;
    [self.navigationController pushViewController:test animated:YES];
}
-(void)selectImageView:(UIImage *)image
{
    _image = image;
    [self skipNext];
    
    NSLog(@"%s",__func__);
}
//根据字体计算表情的高度
- (CGFloat)heightWithFont:(UIFont *)font {
    
    if (!font){font = [UIFont systemFontOfSize:17];}
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGSize maxsize = CGSizeMake(100, MAXFLOAT);
    
    CGSize size = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
