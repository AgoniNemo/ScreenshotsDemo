//
//  ShowColorView.h
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/30.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowColorViewDelegate <NSObject>

-(void)selectColorActionWith:(UIColor *)color;

@end

@interface ShowColorView : UIView

@property (nonatomic ,weak) id<ShowColorViewDelegate> delegate;

@end
