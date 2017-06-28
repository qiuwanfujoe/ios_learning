//
//  LeftDeleteCell.m
//  ios_learning
//
//  Created by Gideon on 26/06/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "LeftDeleteCell.h"

@implementation LeftDeleteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {
    if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
        for (UIButton *btn in subView.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                NSLog(@"%@", btn.titleLabel.text);
                if ([btn.titleLabel.text isEqualToString:@"删除"]) {
                
                }
            }
        }
    }
}
    
}

@end
