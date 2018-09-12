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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButton];
}


- (void) setupButton{
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, 200, 200);
   
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

    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)click: (UIButton *)button {
    button.selected = !button.selected;
    UIControlState state = button.selected ? UIControlStateSelected : UIControlStateNormal;
    [button adjustButtonStyleWithState:state];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end




