//
//  UIAlertView+show.m
//  MVCDemo
//
//  Created by chenxinju on 16/5/24.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import "UIAlertView+show.h"

@implementation UIAlertView(show)
+ (void)showAlertWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
