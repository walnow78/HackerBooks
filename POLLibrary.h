//
//  POLLibrary.h
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import Foundation;

@class POLBook, POLLibrary;


#import "POLBookViewController.h"


@protocol POLLibraryDelegate <NSObject>

-(void) library:(POLLibrary*) lib didChangeModel:(POLLibrary*) model;

@end

@interface POLLibrary : NSObject <POLBookViewControllerDelegate>

@property(nonatomic,strong) NSMutableDictionary *libraryByTag;
@property(nonatomic,strong) NSArray* tags;

@property (nonatomic,weak) id <POLLibraryDelegate> delegate;

-(id) init;

-(NSUInteger) tagsCount;
-(NSUInteger) booksCount;
-(NSArray*) tags;
-(NSUInteger) bookCountForTag:(NSString*) tag;
-(NSArray*) booksForTag: (NSString *) tag;
-(POLBook*) bookForTag:(NSString*) tag atIndex:(NSUInteger) index;

@end

