//
//  DDBaseTableViewCell.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpCellLayout];
    }

    return self;
}

- (void)setUpCellLayout {

}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName
{
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellName owner:nil options:nil] firstObject];
    }
//    if (!cell) {
//        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
//    }
    
    return cell;    
}

+ (CGFloat)tableViewCellHeight {
    return 44.f;
}

@end
