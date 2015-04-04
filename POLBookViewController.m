//
//  POLBookViewController.m
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBook.h"
#import "POLBookViewController.h"
#import "POLUtils.h"
#import "POLPdfViewController.h"

@interface POLBookViewController ()

@end

@implementation POLBookViewController


-(id) initWithModel:(POLBook*) model{
    
    if (self = [super init]) {
        
        _model = model;
        
    }
    
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7){
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }

    // Show the button library the first time
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(didChangeBook:)
                   name:@"didChangeBook"
                 object:nil];
    
    
    [self syncViewModel];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) didChangeBook:(NSNotification*) info{
    
    NSDictionary *dic = [info userInfo];
    
    POLBook *book = [dic objectForKey:@"book"];
    
    self.model = book;
    
    [self syncViewModel];
    
}

#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

#pragma mark - Utils

-(void) syncViewModel{
    
    POLUtils *utils = [[POLUtils alloc] init];
    
    
    self.title = self.model.title;
    self.tagsLabel.text = [self.model.tags componentsJoinedByString:@", "];
    self.authorsLabel.text = [self.model.authors componentsJoinedByString:@", "];
    [self.favoriteSwitch setOn:self.model.favorite];
    
    self.indicatorActivity.hidden = NO;
    [self.indicatorActivity startAnimating];
    
    [self.imageView.image = [UIImage alloc] init];
    
    dispatch_queue_t download = dispatch_queue_create("download", 0);
    
    __block NSData *data;
    
    dispatch_async(download, ^{
        
        data = [utils loadFileWithUrl:self.model.urlPdf];
        
        dispatch_queue_t principal = dispatch_get_main_queue();
        
        dispatch_async(principal, ^{
            
            self.imageView.image = [[UIImage alloc] initWithData:[utils loadFileWithUrl:self.model.urlImage]];
            
            
            [self.indicatorActivity stopAnimating];
            
            self.indicatorActivity.hidden = YES;
        });
    });
    
}

#pragma mark - Actions

- (IBAction)showPdf:(id)sender {
    
    POLPdfViewController *pdfVC = [[POLPdfViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pdfVC animated:YES];
}

- (IBAction)makeFavorite:(id)sender {
    
    if ([self.favoriteSwitch isOn]) {
        self.model.favorite = YES;
    }else{
        self.model.favorite = NO;
    }
    
    [self.delegate bookViewController:self
              didChangeStatusFavorite:self.model];
    
    
}

    
@end
