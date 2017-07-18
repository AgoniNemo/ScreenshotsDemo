
## 截图并涂鸦
1. 包含截图功能。
2. 删除全部。
3. 进入、后退、保存到相册功能。

![demo](https://raw.githubusercontent.com/AgoniNemo/ScreenshotsDemo/master/image/demo.png)

### 用法

```
    UIWindow *screenWindow = [[UIApplication sharedApplication].windows lastObject];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    
    [self.navigationController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    DrawRectView *view = [[DrawRectView alloc] initWithFrame:self.view.bounds];
    view.image = viewImage;
    view.isBezier = NO;
    view.delegate = self;
    view.saveImage = YES;
    view.color = [UIColor blackColor];
    [screenWindow addSubview:view];
    
```
