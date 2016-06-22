//
//  UIView+Extion.h
//  HeaderAnimationEffects
//
//  Created by chenxinju on 16/6/22.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extion)

@property (nonatomic,assign)CGFloat x ;
@property (nonatomic,assign)CGFloat y ;
@property (nonatomic,assign)CGFloat width ;
@property (nonatomic,assign)CGFloat height ;
@property (nonatomic,assign)CGFloat centerX ;
@property (nonatomic,assign)CGFloat centerY;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGSize size;

//Method
- (void)setLayerWithCr:(CGFloat)cornerRadius;
- (void)setBorderWithColor: (UIColor *)color width: (CGFloat)width;
@end
