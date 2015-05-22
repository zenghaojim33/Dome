//
//  CollectionViewCell.m
//  Dome
//
//  Created by BTW on 15/4/29.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)updateCellWithModel:(AllRootModel *)model
{
    self.TitleLabel.text = model.categoryName;
    self.TitleLabel.textAlignment = NSTextAlignmentCenter;
    self.Pic.image = [UIImage imageNamed:@""];
    NSString * Link = [NSString stringWithFormat:@"http://m.dome123.com/pic/%@.png",model.categoryId];
    
    [self.Pic setImageUrlWithFadeInEffect:Link];
}
@end
