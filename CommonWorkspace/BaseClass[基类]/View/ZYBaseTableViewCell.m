//
//  DDBaseTableViewCell.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYBaseTableViewCell.h"

@implementation ZYBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName
{
    
    ZYBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellName owner:nil options:nil] firstObject];
    }
    
    return cell;    
}

@end
