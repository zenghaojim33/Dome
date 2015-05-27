//
//  UIView+IBAppearance.m
//  Dome
//
//  Created by Anson on 15/5/27.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "UIView+IBAppearance.h"
#import <objc/runtime.h>

#define BORDER_COLOR_KEYPATH @"borderColor"

@implementation UIView (IBAppearance)

- (void)setBorderColor:(UIColor *)borderColor {
    UIColor *bc = objc_getAssociatedObject(self, BORDER_COLOR_KEYPATH);
    if(bc == borderColor) return;
    else {
        objc_setAssociatedObject(self, BORDER_COLOR_KEYPATH, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.layer.borderColor = [borderColor CGColor];
    }
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, BORDER_COLOR_KEYPATH);
}

@end
