//
//  DrawModel.h
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/25.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawModel : NSObject

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) CGFloat lineWidth;

@end


@interface DrawSubModel : DrawModel

@property (nonatomic,strong) NSMutableArray *paths;

@end

@interface DrawBezierModel : DrawModel

@property (nonatomic,strong) UIBezierPath *path;

@end
