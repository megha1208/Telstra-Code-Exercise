//
//  SubtitleTableViewCell.m
//  TelstraPOC
//
//  Created by mac_admin on 01/12/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import "SubtitleTableViewCell.h"

@implementation SubtitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}

@end
