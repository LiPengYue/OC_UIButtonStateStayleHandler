//
//  ViewController.m
//  AttributedString
//
//  Created by 李鹏跃 on 2018/8/25.
//  Copyright © 2018年 13lipengyue. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Handler.h"

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray <UIButton *>*buttonArrayM;
@property (nonatomic,weak) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
    [self createButtons];
    [self setupSwitchButton];
    [self clickButton:self.buttonArrayM.firstObject];
}


- (void) setupButton{
    
    UIButton *button = [UIButton new];
    self.button = button;
    [self.view addSubview:button];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 200, 200);
   
    [button setUpStyle:UIControlStateNormal style:^(UIButton *button) {
        button
        .setUpTitle(@"normal")
        .setUpTitleColor([UIColor blueColor])
        .setUpBorderWidth(5)
        .setUpBorderColor([UIColor blueColor])
        .setUpBackgroundColor([UIColor colorWithWhite:0.9 alpha:0.9])
        .setUpFont([UIFont systemFontOfSize:32])
        .setUpCornerRadius(30);
    }];

    [button setUpStyle:UIControlStateSelected style:^(UIButton *button) {
        button
        .setUpTitle(@"selected")
        .setUpTitleColor([UIColor brownColor])
        .setUpBorderWidth(7)
        .setUpBorderColor([UIColor brownColor])
        .setUpBackgroundColor([UIColor colorWithWhite:0.7 alpha:0.7])
        .setUpFont([UIFont systemFontOfSize:25])
        .setUpCornerRadius(60);
    }];
    
    [button setUpStyle:UIControlStateHighlighted style:^(UIButton *button) {
        button
        .setUpTitle(@"highlighted")
        .setUpTitleColor([UIColor yellowColor])
        .setUpBorderWidth(9)
        .setUpBorderColor([UIColor yellowColor])
        .setUpBackgroundColor([UIColor colorWithWhite:0.5 alpha:0.5])
        .setUpFont([UIFont systemFontOfSize:18])
        .setUpCornerRadius(100);
    }];
 
//    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}
//- (void)click: (UIButton *)button {
//    button.selected = !button.selected;
//    UIControlState state = button.selected ? UIControlStateSelected : UIControlStateNormal;
//    [button adjustButtonStyleWithState:state];
//}

- (void) setupSwitchButton {
    [self.buttonArrayM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
        obj.frame = CGRectMake(100 * idx + 10, self.view.frame.size.height / 2 - 200, 90, 20);
    }];
}

- (void) createButtons {
    self.buttonArrayM = [NSMutableArray new];
    
    UIButton *buttonNormal = [UIButton new];
    buttonNormal.setUpTitle(@"normal");
    
    UIButton *buttonSelected = [UIButton new];
    buttonSelected.setUpTitle(@"selected");
    
    UIButton *buttonHighlighted = [UIButton new];
    buttonHighlighted.setUpTitle(@"highlighted");
    
    [self.buttonArrayM addObject:buttonNormal];
    [self.buttonArrayM addObject:buttonSelected];
    [self.buttonArrayM addObject:buttonHighlighted];
    
    [self.buttonArrayM enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setUpStyle:UIControlStateNormal style:^(UIButton *button) {
            button
            .setUpTitleColor(UIColor.lightGrayColor)
            .setUpFont([UIFont systemFontOfSize:10])
            .setUpBackgroundColor([UIColor whiteColor])
            .setUpCornerRadius(10)
            .setUpMasksToBounds(true)
            .setUpBorderColor(UIColor.lightGrayColor)
            .setUpBorderWidth(2);
        }];
        [obj setUpStyle:UIControlStateSelected style:^(UIButton *button) {
            button
            .setUpTitleColor(UIColor.redColor)
            .setUpFont([UIFont systemFontOfSize:13])
            .setUpBackgroundColor([UIColor whiteColor])
            .setUpCornerRadius(10)
            .setUpMasksToBounds(true)
            .setUpBorderColor(UIColor.redColor)
            .setUpBorderWidth(2);
        }];
        [obj addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void) clickButton: (UIButton *)button {
    
    [self.buttonArrayM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = obj == button;
        [obj adjustButtonStyleWithState:UIControlStateNormal];
    }];
    [button adjustButtonStyleWithState:UIControlStateSelected];
    UIControlState state = UIControlStateNormal;
    
    NSInteger index = [self.buttonArrayM indexOfObject:button];
    switch (index) {
        case 1:
            state = UIControlStateSelected;
            self.button.selected = true;
            self.button.highlighted = false;
            break;
        case 2:
            state = UIControlStateHighlighted;
            self.button.selected = false;
            self.button.highlighted = true;
            break;
        default:
            state = UIControlStateNormal;
            self.button.selected = false;
            self.button.highlighted = false;
            break;
    }
    [self.button adjustButtonStyleWithState:state];
}
@end




