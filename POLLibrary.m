//
//  POLLibrary.m
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLLibrary.h"
#import "POLBook.h"
#import "POLUtils.h"

@interface POLLibrary()

@property (nonatomic, strong) NSMutableArray* library;

@end


@implementation POLLibrary


-(id) init{
    
    if (self = [super init]) {
        
        NSURL *url = [[NSURL alloc] initWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"];
        
        POLUtils *utils = [[POLUtils alloc] init];
        
        NSData *data =  [utils loadFileWithUrl:url];
        
        NSError *error;
        
        if (data != nil) {
            
            id json = [NSJSONSerialization JSONObjectWithData:data
                                                      options:kNilOptions
                                                        error:&error];
            
            if (json !=nil) {
                
                if ([json isKindOfClass: [NSDictionary class]]){
                    
                    POLBook *book = [POLBook bookInitWithDictionary:json];
                    
                    [self.library addObject:book];
                    
                }else{
                    
                    self.library = [[NSMutableArray alloc] initWithCapacity:[json count]];
                    
                    // Read de json
                    
                    for(NSDictionary *each in json){
                        
                        POLBook *book = [POLBook bookInitWithDictionary:each];
                        
                        [self.library addObject:book];
                    }
                }
                
            }else{
                NSLog(@"Error convert json to array: %@", error.localizedDescription);
            }
            
        }
        
        [self convertLibraryToDictionary];
        
    }
    
    return self;
    
}

#pragma mark - POLBookViewControllerDelegate

-(void) bookViewController:(POLBookViewController *)bookVC didChangeStatusFavorite:(POLBook *)book{
    
    for (POLBook* each in self.library) {
        if (each.title == book.title){
            
            each.favorite = book.favorite;
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            
            if (book.favorite == YES) {
                [ud setObject:book.title forKey:book.title];
            }else{
                [ud removeObjectForKey:book.title];
            }
            
            [ud synchronize];
        }
    }
    
    [self convertLibraryToDictionary];
    
    
    // alert to delegate
    
    [self.delegate library:self didChangeModel:self];
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    
//    
//    [defaultCenter postNotificationName:@"didBookFavorite"
//                                 object:self
//                               userInfo:@{@"book":self.model}];
    
    
}



#pragma mark - Utils


-(void) convertLibraryToDictionary{
    
    self.libraryByTag = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *fav = [[NSMutableArray alloc] init];
    
    for (POLBook* book in self.library) {
        
        if (book.favorite == YES) {
            
            [[self.libraryByTag objectForKey:@"Favorites"] addObject:book];
            
            [fav addObject:book];
            
        }else{
            
            for (NSString* each in book.tags) {
                
                // Remove the space from tag.
                
                NSString *tag = [each stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                if ([self.libraryByTag objectForKey:tag]){
                    
                    // The tag exist in dictionary, I add the book to current tag.
                    
                    [[self.libraryByTag objectForKey:tag] addObject:book];
                    
                }else{
                    
                    // The tag don't exist, is necesary create the tag.
                    
                    [self.libraryByTag setValue:[[NSMutableArray alloc]initWithObjects:book, nil]  forKey:tag];
                }
            }
        }
    }
    
    // Retrive the different tag from dictionary.
    
    self.tags = [[self.libraryByTag allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    if ([fav count] > 0) {
        
        [self.libraryByTag setValue:fav forKey:@"Favorites"];
        
        // Add the Favorites to array tags
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        [mutableArray addObject:@"Favorites"];
        [mutableArray addObjectsFromArray:self.tags];
        
        self.tags = mutableArray;
        
    }
}

#pragma mark - public

-(NSUInteger) tagsCount{
    return [self.tags count];
}

-(NSUInteger) booksCount{
    return [self.library count];
}

-(NSUInteger) bookCountForTag:(NSString*) tag{
    
    return [[self.libraryByTag objectForKey:tag] count];
    
}

-(NSArray*) booksForTag: (NSString *) tag{
    return [self.libraryByTag objectForKey:tag];
    
}
-(POLBook*) bookForTag:(NSString*) tag atIndex:(NSUInteger) index{
    return [[self.libraryByTag objectForKey:tag] objectAtIndex:index];
}


@end

