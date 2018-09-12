//
//  UIButton+Handler.h
//  AttributedString
//
//  Created by 李鹏跃 on 2018/9/11.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Handler)

/**
 * @brief 设置state对应的button样式
 *
 * 当调用adjustButtonStyleWithState方法时，button才会改变到相应的样式
 * @warning 注意: 非线程安全，到主线程更新参数
 */
- (void)setUpStyle:(UIControlState) state style:(void(^)(UIButton *button))callBack;

/**
 * @brief 改变通过 setUpStyle:do: 方法设置好的button样式
 *
 * @warning 注意: 如果某个样式没有找到相应state下的值，就会设置成normal状态下的样式 如果normal状态下仍未找到，则保持当前状态
 */
- (void) adjustButtonStyleWithState: (UIControlState) state;


/**
 * @brief 设置normal 状态下的Font
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置state对应的font
 */
- (UIButton *(^)(UIFont *)) setUpFont;

/**
 * @brief 设置normal 状态下的titleColor
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置state对应的titleColor
 */
- (UIButton *(^)(UIColor *)) setUpTitleColor;

/**
 * @brief 设置normal 状态下的背景色
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置state对应的backgroundColor
 */
- (UIButton *(^)(UIColor *)) setUpBackgroundColor;

/**
 * @brief 设置normal 状态下的Font
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置state对应的title
 */
- (UIButton *(^)(NSString *)) setUpTitle;

/**
 * @brief 设置normal 状态下的】AttributedString
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置state对应的AttributedString
 */
- (UIButton *(^)(NSAttributedString *)) setUpAttributedString;


/**
 * @brief 设置normal 状态下的image
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置的是对应state的image
 */
- (UIButton *(^)(UIImage *)) setUpImage;

/**
 * @brief 设置normal 状态下的backgroundImage
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置的是对应state的backgroundImage
 */

- (UIButton *(^)(UIImage *)) setUpBackgroundImage;

/**
 * @brief 设置normal 状态下的layer BorderWidth
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置的是对应state的BorderWidth
 */
- (UIButton *(^)(CGFloat)) setUpBorderWidth;

/**
 * @brief 设置normal 状态下的layer border color
 *
 * @return 返回 一个返回self的block.
 *
 * @warning 注意: 在 setUpStyle:setUp: 方法中 设置的是对应state的BorderColor
 */
- (UIButton *(^)(UIColor *)) setUpBorderColor;
@end
