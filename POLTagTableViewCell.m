//
//  POLTagTableViewCell.m
//  Modelo
//
//  Created by Pawel Walicki on 1/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLTagTableViewCell.h"

@implementation POLTagTableViewCell

+(NSString*) cellId{
    
    return NSStringFromClass(self);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
