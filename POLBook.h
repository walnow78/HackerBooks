//
//  POLBook.h
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface POLBook : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSArray *authors;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSURL *urlImage;
@property (nonatomic, strong) NSURL *urlPdf;
@property (nonatomic, assign) BOOL favorite;

+(id)bookInitWithTitle:(NSString *)title
               authors:(NSArray *)authors
                  tags:(NSArray *)tags
              urlImage:(NSURL *)urlImage
                urlPdf:(NSURL *)urlPdf
              favorite:(BOOL)favorite;

+(id)bookInitWithDictionary:(NSDictionary*) dictionary;

-(id)initWithTitle:(NSString *)title
           authors:(NSArray *)authors
              tags:(NSArray *)tags
          urlImage:(NSURL *)urlImage
            urlPdf:(NSURL *)urlPdf
          favorite:(BOOL)favorite;

-(id)initWithDictionary:(NSDictionary*) dictionary;

@end
