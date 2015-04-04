//
//  POLLibraryTableViewController.h
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import UIKit;

@class POLBook, POLLibraryTableViewController;
#import "POLLibrary.h"

@protocol POLLibraryTableViewControllerDelegate <NSObject>

-(void) libraryTableViewControllerDelegate:(POLLibraryTableViewController*) lVC didSelectBook:(POLBook*) book;

@end


@interface POLLibraryTableViewController : UITableViewController <POLLibraryTableViewControllerDelegate, POLLibraryDelegate>

@property (nonatomic, strong) POLLibrary* model;
@property (nonatomic, weak) id <POLLibraryTableViewControllerDelegate> delegate;

-(id) initWithStyle:(UITableViewStyle)style model:(POLLibrary*) model;

@end
