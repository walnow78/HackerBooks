//
//  POLLibraryTableViewController.m
//  Modelo
//
//  Created by Pawel Walicki on 31/3/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLLibraryTableViewController.h"
#import "POLBook.h"
#import "POLUtils.h"
#import "POLTagTableViewCell.h"
#import "POLLibrary.h"
#import "POLBookViewController.h"

@interface POLLibraryTableViewController ()

@end

@implementation POLLibraryTableViewController

-(id) initWithStyle:(UITableViewStyle)style model:(POLLibrary*) model{
    
    if (self = [super initWithStyle:style]) {
        
        self.model = model;
        
        self.title = @"Library";
    }
    
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
   
    UINib *nib = [UINib nibWithNibName:@"POLTagTableViewCell" bundle:[NSBundle mainBundle]];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:[POLTagTableViewCell cellId]];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(didBookFavorite:)
                   name:@"didBookFavorite"
                 object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //[center removeObserver:self];
    
}

-(void)viewDidUnload{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];

    
}

#pragma mark - Notification from POLBookViewController

-(void) didBookFavorite: (NSNotification*) info{
    
    NSDictionary *dic = [info userInfo];
    
    POLBook *book = [dic objectForKey:@"book"];
    
    [self.model changeStatusFavorite:book];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.model tagsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.model bookCountForTag:[self.model.tags objectAtIndex:section]];

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.model.tags objectAtIndex:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *tag = [self.model.tags objectAtIndex:indexPath.section];
    
    POLBook *book = [self.model bookForTag:tag atIndex:indexPath.row];

    NSString *cellId = [POLTagTableViewCell cellId];
    
    POLTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
    
    cell.titleBook.text = book.title;
    cell.authorsBook.text = [book.authors componentsJoinedByString:@", "];
    
    dispatch_queue_t download = dispatch_queue_create("download", 0);
    
    // Enviar el bloque que se ejecuta en 2o plano
    
    __block NSData *data;
    
    dispatch_async(download, ^{
        
        data =  [[[POLUtils alloc] init] loadFileWithUrl:book.urlImage];
        
        dispatch_queue_t principal = dispatch_get_main_queue();
        
        dispatch_async(principal, ^{
            
            cell.imageBook.image = [[UIImage alloc] initWithData:data];
        });
    });
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POLBook *book = [self.model bookForTag:[self.model.tags objectAtIndex:indexPath.section] atIndex:indexPath.row];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter postNotificationName:@"didChangeBook"
                                 object:self
                               userInfo:@{@"book":book}];
    
    [self.delegate libraryTableViewControllerDelegate:self didSelectBook:book];
    
    
}

#pragma mark - POLLibraryTableViewControllerDelegate

-(void) libraryTableViewControllerDelegate:(POLLibraryTableViewController *)lVC didSelectBook:(POLBook *)book{
    
    POLBookViewController *bookVC = [[POLBookViewController alloc] initWithModel:book];
    
    [self.navigationController pushViewController:bookVC animated:YES];
    
}











@end
