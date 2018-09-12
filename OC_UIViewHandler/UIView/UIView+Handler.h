//
//  UIView+Handler.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/9/11.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Handler.h"

@interface UIView (Handler)
/// CGFloat 圆角大小
- (UIView *(^)(CGFloat)) setUpCornerRadius;
/// BOOL 超出范围是否显示
- (UIView *(^)(BOOL)) setUpMasksToBounds;

/// CGFloat 边框宽度
- (UIView *(^)(CGFloat)) setUpBorderWidth;
/// UIColor 边框颜色
- (UIView *(^)(UIColor *)) setUpBorderColor;

/// UIColor 设置背景色
- (UIView *(^)(UIColor *)) setUpBackgroundColor;
@end
