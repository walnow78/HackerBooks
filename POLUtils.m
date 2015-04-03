//
//  POLUtils.m
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "POLUtils.h"

@implementation POLUtils

-(NSData *) loadFileWithUrl:(NSURL*) url{
    
    // check if the image exist in sandbox.
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSString* fileName = [url lastPathComponent];
    
    NSURL *patchCache = [[filemanager URLsForDirectory:NSCachesDirectory
                                             inDomains:NSUserDomainMask] lastObject];
    
    NSURL *fullPatch = [patchCache URLByAppendingPathComponent:fileName];
    
    BOOL exist = [filemanager fileExistsAtPath:[fullPatch path] isDirectory:NO];
    
    NSData *data;
    
    if (exist) {
        
        // file exist in cache directory
        
        NSError *error;
        
        data = [NSData dataWithContentsOfURL:fullPatch
                                     options:NSDataReadingMappedIfSafe
                                       error:&error];
        
        if (data == nil){
            NSLog(@"Error loading the file: %@", error.localizedDescription);
        }
        
        
    }else{
        
        // file don't exist, download file
        
        data = [self downloadFileFromUrl:url];
    }
    
    return data;
    
}


-(NSData*) downloadFileFromUrl:(NSURL*) url{
    
    NSError *error;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    if (data != nil) {
        
        [self saveFileWithData:data name:[url lastPathComponent]];
        
    }else{
        NSLog(@"Error downloading file: %@", error.localizedDescription);
    }
    
    return data;
}

-(void) saveFileWithData:(NSData*) data
                    name:(NSString*) name{
    
    // Save the file in "Cache" directoy
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSURL* url = [[filemanager URLsForDirectory:NSCachesDirectory
                                      inDomains:NSUserDomainMask] lastObject];
    
    url = [url URLByAppendingPathComponent:name];
    
    BOOL rc = NO;
    NSError *error;
    
    rc = [data writeToURL:url options:NSDataWritingAtomic error:&error];
    
    if (rc==NO) {
        NSLog(@"Error saving file in cache: %@", error.localizedDescription);
    }
    
}


@end
