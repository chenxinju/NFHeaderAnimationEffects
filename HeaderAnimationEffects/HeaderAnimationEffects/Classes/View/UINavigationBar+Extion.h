//
//  UINavigationBar+Extion.h
//  HeaderAnimationEffects
//
//  Created by chenxinju on 16/6/22.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extion)

//如想实现导航颜色的渐变 ，则translucent 属性不可为no，系统默认为yes
- (void)ps_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ps_setElementsAlpha:(CGFloat)alpha;
- (void)ps_setTranslationY:(CGFloat)translationY;
- (void)ps_setTransformIdentity;
- (void)ps_reset;
@end
