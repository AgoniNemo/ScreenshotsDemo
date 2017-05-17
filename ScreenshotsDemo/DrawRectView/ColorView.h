//
//  ColorView.h
//  JS_OC_Demo
//
//  Created by Nemo on 2016/11/26.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectColor)(UIColor*);
typedef void(^ReturnPrevious)();
@interface ColorView : UIView

@property (nonatomic ,copy) SelectColor selectColor;
@property (nonatomic ,copy) ReturnPrevious returnPrevious;
@end
