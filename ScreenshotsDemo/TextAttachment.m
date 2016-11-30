//
//  TextAttachment.m
//  ScreenshotsDemo
//
//  Created by Mjwon on 2016/11/30.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "TextAttachment.h"

#define emotionRate 1.0

@implementation TextAttachment

//在这个方法里返回附件的位置
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
    //    self.emotionRect = CGRectMake(position.x, position.y + 0.5, _emojiSize.width * emotionRate, _emojiSize.height * emotionRate);
    
    return CGRectMake(0, -4, _size.width * emotionRate, _size.height * emotionRate);
}

@end
