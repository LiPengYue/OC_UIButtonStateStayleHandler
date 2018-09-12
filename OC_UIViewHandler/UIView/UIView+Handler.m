//
//  UIView+Handler.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/9/11.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "UIView+Handler.h"

@implementation UIView (Handler)

- (UIView *(^)(CGFloat)) setUpCornerRadius {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat radius) {
        weakSelf.layer.cornerRadius = radius;
        return weakSelf;
    };
}
- (UIView *(^)(BOOL)) setUpMasksToBounds {
    __weak typeof (self) weakSelf = self;
    return ^(BOOL masksToBounds) {
        weakSelf.layer.masksToBounds = masksToBounds;
        return weakSelf;
    };
}

- (UIView *(^)(CGFloat)) setUpBorderWidth {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat borderWidth) {
        weakSelf.layer.borderWidth = borderWidth;
        return weakSelf;
    };
}
- (UIView *(^)(UIColor *)) setUpBorderColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *borderColor) {
        weakSelf.layer.borderColor = borderColor.CGColor;
        return weakSelf;
    };
}

- (UIView *(^)(UIColor *)) setUpBackgroundColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *backgroundColor) {
        weakSelf.backgroundColor = backgroundColor;
        return weakSelf;
    };
}
@end
