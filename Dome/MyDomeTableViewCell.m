//
//  MyDomeTableViewCell.m
//  Dome
//
//  Created by BTW on 15/1/28.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "MyDomeTableViewCell.h"
#import "UIImageView+FadeInEffect.h"
@implementation MyDomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)TouchDown:(id)sender
{
    [self.delegate TouchDownForTag:self.tag];
}
- (IBAction)TouchCopy:(id)sender {
    [self.delegate TouchCopyForTag:self.tag];
}
- (IBAction)TouchShare:(id)sender {
    [self.delegate TouchShareForTag:self.tag];
}


-(void)updateCellWithModel:(ProductModel *)model
{
    self.selectionStyle = UITableViewCellAccessoryNone;

    self.productName.text = model.productName;
    float price = [model.price floatValue];
    self.price.text = [NSString stringWithFormat:@"¥%.2f",price];
    self.isMyDome = YES;
    self.categoryName.text = model.categoryName;
    self.TitleImages.image = [UIImage imageNamed:@""];
    NSString * path = model.TitleImages[0];
    [self.TitleImages setImageUrlWithFadeInEffect:path];
    
    float shopPrice = model.shopPrice.floatValue;
    self.inPrice.text = [NSString stringWithFormat:@"佣金:人民币%.2f",(price - shopPrice)*0.52];
    
    if (model.isSelect == YES)
    {
        [self.CellButton setTitle:@"已选择" forState:UIControlStateNormal];
        [self.CellButton setTitleColor:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] forState:UIControlStateNormal];
        [self.CellButton setImage:[UIImage imageNamed:@"25_right2.png"] forState:UIControlStateNormal];
    }else{
        [self.CellButton setTitle:@"下架" forState:UIControlStateNormal];
        // [cell.CellButton setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
        [self.CellButton setImage:[UIImage imageNamed:@"25_cannel1.png"] forState:UIControlStateNormal];
    }
}

@end
