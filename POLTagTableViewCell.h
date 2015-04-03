//
//  POLTagTableViewCell.h
//  Modelo
//
//  Created by Pawel Walicki on 1/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POLTagTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UILabel *titleBook;
@property (weak, nonatomic) IBOutlet UILabel *authorsBook;

+(NSString*) cellId;

@end
