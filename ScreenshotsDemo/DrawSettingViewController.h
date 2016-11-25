//
//  DrawSettingViewController.h
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/25.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawModel.h"

@interface DrawSettingViewController : UIViewController

@property (nonatomic,assign) CGFloat r;

@property (nonatomic,assign) CGFloat g;

@property (nonatomic,assign) CGFloat b;

@property (nonatomic,copy) void (^block)(DrawModel *model);

@end
