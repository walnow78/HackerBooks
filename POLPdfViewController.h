//
//  POLPdfViewController.h
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import UIKit;

@interface POLPdfViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *pdfWebView;
@property (nonatomic, strong) POLBook* model;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorActivity;

-(id) initWithModel:(POLBook*) model;


@end
