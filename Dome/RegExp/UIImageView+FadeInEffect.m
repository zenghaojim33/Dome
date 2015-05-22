//
//  UIImageView+FadeInEffect.m
//  Dome
//
//  Created by Anson on 15/5/19.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "UIImageView+FadeInEffect.h"

@implementation UIImageView (FadeInEffect)


-(void)setImageUrlWithFadeInEffect:(NSString *)urlString{
    
    NSURL * imageUrl = [NSURL URLWithString:urlString];
    [self sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (cacheType == SDImageCacheTypeNone) {
            self.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1;
            }];
        } else {
            self.alpha = 1;
        }
        
    }];
}
@end
