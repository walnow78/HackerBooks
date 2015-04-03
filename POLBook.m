//
//  POLBook.m
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLBook.h"

@implementation POLBook

+(id)bookInitWithTitle:(NSString *)title
               authors:(NSArray *)authors
                  tags:(NSArray *)tags
              urlImage:(NSURL *)urlImage
                urlPdf:(NSURL *)urlPdf
              favorite:(BOOL)favorite{
    
    return [[self alloc] initWithTitle:title
                               authors:authors
                                  tags:tags
                              urlImage:urlImage
                                urlPdf:urlPdf
                              favorite:NO];
    
}

+(id)bookInitWithDictionary:(NSDictionary*) dictionary{
    
    return [[self alloc] initWithDictionary:dictionary];
    
}

-(id)initWithTitle:(NSString *)title
           authors:(NSArray *)authors
              tags:(NSArray *)tags
          urlImage:(NSURL *)urlImage
            urlPdf:(NSURL *)urlPdf
          favorite:(BOOL)favorite{
    
    if (self = [super init]) {
        
        _title = title;
        _authors = authors;
        _tags = tags;
        _urlImage = urlImage;
        _urlPdf = urlPdf;
        _favorite = favorite;
        
    }
    
    return self;
    
}

-(id)initWithDictionary:(NSDictionary*) dictionary{
    
    if (self = [super init]) {
        _title = [dictionary objectForKey:@"title"];
        _authors = [self convertTextToArray:[dictionary objectForKey:@"authors"]];
        _tags = [self convertTextToArray:[dictionary objectForKey:@"tags"]];
        _urlImage = [[NSURL alloc] initWithString:[dictionary objectForKey:@"image_url"]];
        _urlPdf = [[NSURL alloc] initWithString:[dictionary objectForKey:@"pdf_url"]];
        
        
        // Check if the book is favorite
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([ud objectForKey:_title] != nil){
            _favorite = YES;
        }else{
            
            _favorite = NO;
        }
        
    }
    
    return self;
    
}

-(NSArray*) convertTextToArray: (NSString*) text{
    
    NSArray *array = [text componentsSeparatedByString:@","];
    
    return array;
    
}

@end
