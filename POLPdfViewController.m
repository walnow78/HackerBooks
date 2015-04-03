//
//  POLPdfViewController.m
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBook.h"
#import "POLPdfViewController.h"
#import "POLUtils.h"

@interface POLPdfViewController ()

@end

@implementation POLPdfViewController

-(id) initWithModel:(POLBook*) model{
    
    if (self = [super init]) {
        
        _model = model;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
   
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(didChangeBook:)
                   name:@"didChangeBook"
                 object:nil];
    
      [self syncViewModel];

}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center removeObserver:self];
}

-(void) didChangeBook:(NSNotification*) info{
    
    NSDictionary *dic = [info userInfo];
    
    POLBook *book = [dic objectForKey:@"book"];
    
    self.model = book;
    
    [self syncViewModel];
    
}

-(void) syncViewModel{
    
    self.title = self.model.title;
    
    POLUtils *utils = [[POLUtils alloc] init];
    
    self.indicatorActivity.hidden = NO;
    [self.indicatorActivity startAnimating];
    
    // Create the queue
    
    dispatch_queue_t download = dispatch_queue_create("download", 0);
    
    // Send the block to background
    
    __block NSData *data;
    
    dispatch_async(download, ^{
        
        data = [utils loadFileWithUrl:self.model.urlPdf];
        
        // Retrieve main queue
        
        dispatch_queue_t principal = dispatch_get_main_queue();
        
        dispatch_async(principal, ^{
            
            [self.pdfWebView loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];

            [self.indicatorActivity stopAnimating];
            
            self.indicatorActivity.hidden = YES;
        });
    });
    
}

@end
