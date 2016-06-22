//
//  NFBottomBar.h
//  HeaderAnimationEffects
//
//  Created by chenxinju on 16/6/22.
//  Copyright © 2016年 Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    BottomBarType_Original,
    BottomBarType_Up
    
}BottomBarType;
typedef void (^clickBarBlock)(BottomBarType type);

@interface NFBottomBar : UIView

@property (nonatomic,copy)clickBarBlock block;
@end
