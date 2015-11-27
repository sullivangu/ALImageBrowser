//
//  TableViewCell.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/27.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "XXTableViewCell.h"
#import "Masonry.h"

@implementation XXTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.myImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.myImageView];
        [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];

    }
    return self;
}
@end
