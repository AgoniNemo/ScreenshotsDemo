//
//  DrawRectView.h
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawRectViewDelegate <NSObject>

-(void)selectImageView:(UIImage *)image;

@end

@interface DrawRectView : UIView

@property (nonatomic ,strong) UIImage *image;

@property (nonatomic ,strong) UIColor *color;

@property (nonatomic ,assign) CGFloat lineWidth;
@property (nonatomic ,assign) BOOL saveImage;
@property (nonatomic ,assign) BOOL isBezier;
    
@property (nonatomic ,weak) id<DrawRectViewDelegate> delegate;
    
@end
