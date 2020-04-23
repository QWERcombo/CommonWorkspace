//
//  DDBaseTableViewCell.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseTableViewCell : UITableViewCell


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName;

@end

NS_ASSUME_NONNULL_END
