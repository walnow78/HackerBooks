//
//  POLBookViewController.h
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import UIKit;
@class POLBook;


@interface POLBookViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) POLBook* model;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorActivity;

- (IBAction)makeFavorite:(id)sender;
- (IBAction)showPdf:(id)sender;

-(id) initWithModel:(POLBook*) model;


@end
