# 效果
![selected](https://upload-images.jianshu.io/upload_images/4185621-a6235da15621bd5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![normal](https://upload-images.jianshu.io/upload_images/4185621-7084e6d90e41a46a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

[下载 demo点这里 希望对你有点帮助👌👌](https://github.com/LiPengYue/OC_UIButtonStateStayleHandler)
# 调用
```
UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 200, 200);
```
1. 设置normal 
```
[button setUpStyle:UIControlStateNormal style:^(UIButton *button) {
        button
        .setUpTitle(@"normal")
        .setUpTitleColor([UIColor blueColor])
        .setUpBorderWidth(5)
        .setUpBorderColor([UIColor blueColor])
        .setUpBackgroundColor([UIColor grayColor])
        .setUpFont([UIFont systemFontOfSize:32])
        .setUpCornerRadius(12);
    }];
```
 2. 设置selected状态
```
[button setUpStyle:UIControlStateSelected style:^(UIButton *button) {
        button
        .setUpTitle(@"selected")
        .setUpTitleColor([UIColor redColor])
        .setUpBorderWidth(11)
        .setUpBorderColor([UIColor redColor])
        .setUpBackgroundColor([UIColor lightGrayColor])
        .setUpFont([UIFont systemFontOfSize:20])
        .setUpCornerRadius(100);
    }];
```
3. 刷新button的样式
`adjustButtonStyleWithState:state`
```
- (void)click: (UIButton *)button {
    button.selected = !button.selected;
    UIControlState state = button.selected ? UIControlStateSelected : UIControlStateNormal;
    [button adjustButtonStyleWithState:state];
}
```

# 思路
## 1. 注意
非线程安全 需要在主线程调用
`- (void)setUpStyle:(UIControlState) state style:(void(^)(UIButton *button))callBack`

## 2. 实现
1. 内部添加一个属性记录 `setUpStyle:style:` 传入的style
2. 添加方法 字典，储存相应的状态下的相关样式
```
@property (nonatomic,assign) UIControlState setupState;

@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIColor *>*backgroundColorDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIColor *>*borderColorDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,NSNumber *>*borderWidthDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIFont *>*fontDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *, NSNumber *> *cornerRadiusDictionaryM;
```
3. 添加方法，用来传入相应的属性
>1. 方法需要返回一个block，这个block的返回值需要是self
>2. block当做返回值，相当于顺传参数

.h
```
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
```
.m 
```
#import "UIButton+Handler.h"
#import <objc/runtime.h>

static NSString *const k_setupState = @"k_setupState";
static NSString *const k_setupBackgroundColorDictionaryM = @"k_setupBackgroundColorDictionaryM";
static NSString *const k_borderColorDictionaryM = @"k_borderColorDictionaryM";
static NSString *const k_borderWidthDictionaryM = @"k_borderWidthDictionaryM";
static NSString *const k_fontDictionaryM = @"k_fontDictionaryM";
static NSString *const k_cornerRadiusDictionaryM = @"k_cornerRadiusDictionaryM";
@interface UIButton (Handler)
@property (nonatomic,assign) UIControlState setupState;

@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIColor *>*backgroundColorDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIColor *>*borderColorDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,NSNumber *>*borderWidthDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *,UIFont *>*fontDictionaryM;
@property (nonatomic,strong) NSMutableDictionary <NSNumber *, NSNumber *> *cornerRadiusDictionaryM;
@end

@implementation UIButton (Handler)

- (UIButton *(^)(UIFont *)) setUpFont {
    __weak typeof (self)weakSelf = self;
    return ^(UIFont *font) {
        if (weakSelf.state == weakSelf.setupState) {
            weakSelf.titleLabel.font = font;
        }
        weakSelf.fontDictionaryM[@(weakSelf.setupState)] = font;
        return weakSelf;
    };
}

- (UIButton *(^)(CGFloat)) setUpCornerRadius {
    __weak typeof (self) weakSelf = self;
    return ^(CGFloat radius) {
        if (weakSelf.setupState == weakSelf.state) {
            weakSelf.layer.cornerRadius = radius;
        }
        weakSelf.cornerRadiusDictionaryM[@(weakSelf.setupState)] = @(radius);
        return weakSelf;
    };
}

- (void)setUpStyle:(UIControlState) state style:(void(^)(UIButton *button))callBack {
        self.setupState = state;
        callBack(self);
        self.setupState = UIControlStateNormal;
}

- (UIButton *(^)(UIColor *)) setUpTitleColor {
    __weak typeof (self)weakSelf = self;
    return ^(UIColor *color) {
        [weakSelf setTitleColor:color forState:weakSelf.setupState];
        return weakSelf;
    };
}

- (UIButton *(^)(UIColor *)) setUpBackgroundColor {
    __weak typeof (self)weakSelf = self;
    return ^(UIColor *color) {
        weakSelf.backgroundColor = color;
        weakSelf.backgroundColorDictionaryM[@(weakSelf.setupState)] = color;
        return weakSelf;
    };
}

- (UIButton *(^)(NSString *)) setUpTitle {
    __weak typeof (self)weakSelf = self;
    return ^(NSString *title) {
        [weakSelf setTitle:title forState:weakSelf.setupState];
        return weakSelf;
    };
}

- (UIButton *(^)(NSAttributedString *)) setUpAttributedString {
    __weak typeof (self)weakSelf = self;
    return ^(NSAttributedString *attributedString) {
        [weakSelf setAttributedTitle:attributedString forState:weakSelf.setupState];
        return weakSelf;
    };
}

- (UIButton *(^)(UIImage *))setUpImage {
    __weak typeof (self)weakSelf = self;
    return ^(UIImage *image) {
        [weakSelf setImage:image forState:weakSelf.setupState];
        return weakSelf;
    };
}

- (UIButton *(^)(UIImage *))setUpBackgroundImage {
    __weak typeof (self)weakSelf = self;
    return ^(UIImage *image) {
        [weakSelf setBackgroundImage:image forState:weakSelf.setupState];
        return weakSelf;
    };
}

- (UIButton *(^)(CGFloat)) setUpBorderWidth {
    __weak typeof (self)weakSelf = self;
    return ^(CGFloat borderW) {
        if (weakSelf.state == weakSelf.setupState) {
            weakSelf.layer.borderWidth = borderW;
        }
        weakSelf.borderWidthDictionaryM[@(weakSelf.setupState)] = @(borderW);
        return weakSelf;
    };
}

- (UIButton *(^)(UIColor *)) setUpBorderColor {
    __weak typeof (self)weakSelf = self;
    return ^(UIColor *color) {
        if (weakSelf.state == weakSelf.setupState) {
            weakSelf.layer.borderColor = color.CGColor;
        }
        weakSelf.borderColorDictionaryM[@(weakSelf.setupState)] = color;
        return weakSelf;
    };
}

- (void) adjustButtonStyleWithState: (UIControlState) state {
    [self adjustBackgroundColorWithState:state];
    [self adjustBorderColorWithState:state];
    [self adjustBorderWidthWithState:state];
    [self adjustFontWithState:state];
    [self adjustCornerRadiusWithState:state];
}

- (void) adjustBackgroundColorWithState:(UIControlState)state {
    NSNumber *currenState = @(state);
    NSNumber *normalState = @(UIControlStateNormal);
    UIColor *backgroundColor = self.backgroundColorDictionaryM[currenState];
    
    /// backgroundColor
    if (!backgroundColor) {
        backgroundColor = self.backgroundColorDictionaryM[normalState];
    }
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
    
}
- (void) adjustBorderColorWithState:(UIControlState)state {
    NSNumber *currenState = @(state);
    NSNumber *normalState = @(UIControlStateNormal);
    // borderColor
    UIColor *borderColor = self.borderColorDictionaryM[currenState];
    if (!borderColor) {
        borderColor = self.borderColorDictionaryM[normalState];
    }
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}
- (void) adjustBorderWidthWithState:(UIControlState)state {
    NSNumber *currenState = @(state);
    NSNumber *normalState = @(UIControlStateNormal);
    //borderWidth
    NSNumber *borderWidthNumbser = self.borderWidthDictionaryM[currenState];
    if (!borderWidthNumbser) {
        borderWidthNumbser = self.borderWidthDictionaryM[normalState];
    }
    CGFloat borderWidth = borderWidthNumbser.floatValue;
    self.layer.borderWidth = borderWidth;
}
- (void) adjustFontWithState:(UIControlState)state {
    NSNumber *currenState = @(state);
    NSNumber *normalState = @(UIControlStateNormal);
    //borderWidth
    UIFont *font = self.fontDictionaryM[currenState];
    if (!font) {
        font = self.fontDictionaryM[normalState];
    }
    if (font) {
        self.titleLabel.font = font;
    }
}
- (void) adjustCornerRadiusWithState:(UIControlState)state {
    NSNumber *currenState = @(state);
    NSNumber *normalState = @(UIControlStateNormal);
    //borderWidth
    NSNumber *value = self.cornerRadiusDictionaryM[currenState];
    if (!value) {
        value = self.cornerRadiusDictionaryM[normalState];
    }
    self.layer.cornerRadius = value.floatValue;
}

//MAKR: - get && set
- (void)setSetupState:(UIControlState)setupState {
    objc_setAssociatedObject(self, &k_setupState, @(setupState), OBJC_ASSOCIATION_ASSIGN);
}

- (UIControlState) setupState {
    NSNumber *state = objc_getAssociatedObject(self, &k_setupState);
    return state.integerValue;
}


- (void) setBackgroundColorDictionaryM:(NSMutableDictionary<NSNumber *,UIColor *> *)backgroundColorDictionaryM {
    objc_setAssociatedObject(self, &k_setupBackgroundColorDictionaryM, backgroundColorDictionaryM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)backgroundColorDictionaryM {
    NSMutableDictionary<NSNumber *,UIColor *> *dic = objc_getAssociatedObject(self, &k_setupBackgroundColorDictionaryM);
    if (!dic) {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &k_setupBackgroundColorDictionaryM, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}
- (void) setBorderColorDictionaryM:(NSMutableDictionary<NSNumber *,UIColor *> *)borderColorDictionaryM {
     objc_setAssociatedObject(self, &k_borderColorDictionaryM, borderColorDictionaryM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,UIColor *> *)borderColorDictionaryM {
    NSMutableDictionary<NSNumber *,UIColor *> *dic = objc_getAssociatedObject(self, &k_borderColorDictionaryM);
    if (!dic) {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &k_borderColorDictionaryM, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

- (void)setBorderWidthDictionaryM:(NSMutableDictionary<NSNumber *,NSNumber *> *)borderWidthDictionaryM {
     objc_setAssociatedObject(self, &k_borderWidthDictionaryM, borderWidthDictionaryM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableDictionary<NSNumber *,NSNumber *> *)borderWidthDictionaryM {
    NSMutableDictionary<NSNumber *,NSNumber *> *dic = objc_getAssociatedObject(self, &k_borderWidthDictionaryM);
    if (!dic) {
        dic = [NSMutableDictionary new];
         objc_setAssociatedObject(self, &k_borderWidthDictionaryM, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

- (void)setFontDictionaryM:(NSMutableDictionary<NSNumber *,UIFont *> *)fontDictionaryM {
    objc_setAssociatedObject(self, &k_fontDictionaryM, fontDictionaryM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,UIFont *> *)fontDictionaryM {
    NSMutableDictionary<NSNumber *,UIFont *> *dic = objc_getAssociatedObject(self, &k_fontDictionaryM);
    if (!dic) {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &k_fontDictionaryM, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

- (void)setCornerRadiusDictionaryM:(NSMutableDictionary<NSNumber *,NSNumber *> *)cornerRadiusDictionaryM {
    objc_setAssociatedObject(self, &k_cornerRadiusDictionaryM, cornerRadiusDictionaryM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSNumber *,NSNumber *> *)cornerRadiusDictionaryM {
    NSMutableDictionary<NSNumber *,NSNumber *> *dic = objc_getAssociatedObject(self, &k_cornerRadiusDictionaryM);
    if (!dic) {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &k_cornerRadiusDictionaryM, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}
@end
```


[下载 demo点这里 希望对你有点帮助👌👌](https://github.com/LiPengYue/OC_UIButtonStateStayleHandler)
