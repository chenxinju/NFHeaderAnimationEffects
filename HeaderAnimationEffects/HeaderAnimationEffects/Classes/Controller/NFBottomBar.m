//
//  NFBottomBar.m
//  HeaderAnimationEffects
//
//  Created by chenxinju on 16/6/22.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import "NFBottomBar.h"
#import "UIView+Extion.h"

@implementation NFBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        
        UIButton * originalButton = [self instanceButton];
        originalButton.backgroundColor = [UIColor purpleColor];
        originalButton.x = 0;
        originalButton.tag = BottomBarType_Original;
        [originalButton setTitle:@"导航恢复原样" forState:(UIControlStateNormal)];
        [self addSubview:originalButton];
        
        UIButton * upButton = [self instanceButton];
        upButton.tag = BottomBarType_Up;
        upButton.backgroundColor = [UIColor colorWithRed:38/255.0f green:177/255.0f blue:232/255.0f alpha:1];
        upButton.x = CGRectGetMaxX(originalButton.frame);
        [upButton setTitle:@"导航上移" forState:(UIControlStateNormal)];
        [self addSubview:upButton];
    }
    return self;
}
- (UIButton *)instanceButton
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.userInteractionEnabled = YES;
    customButton.y = 0;
    customButton.size = CGSizeMake(self.width / 2, self.height);
    [customButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [customButton addTarget:self action:@selector(clickEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return customButton;
}
- (void)clickEvent:(UIButton*)sender
{
    if (self.block) {
        _block ((BottomBarType)sender.tag);
    }
}


@end
