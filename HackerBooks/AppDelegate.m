//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Pawel Walicki on 3/4/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "AppDelegate.h"
#import "POLLibrary.h"
#import "POLLibraryTableViewController.h"
#import "POLBookViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Create the model
    
    POLLibrary *library = [[POLLibrary alloc] init];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // For tablet
        [self configureForPadWithModel:(POLLibrary*) library];
        
    }else{
        
        // For phone
        [self configureForPhoneWithModel:(POLLibrary*)library];
        
        
    }
    
    return YES;
}


#pragma mark - Utils

-(void)configureForPadWithModel:(POLLibrary*) library{
    
    POLBook *book = [library bookForTag:[library.tags objectAtIndex:1] atIndex:0];
    
    // Create the viewControllers
    
    POLLibraryTableViewController *tagsVC = [[POLLibraryTableViewController alloc] initWithStyle:UITableViewStylePlain
                                                                                           model:library];
    
    POLBookViewController *bookVC = [[POLBookViewController alloc] initWithModel:book];
    
    // Create navigateControllers
    
    UINavigationController *tagsNC = [[UINavigationController alloc] initWithRootViewController:tagsVC];
    UINavigationController *bookNC = [[UINavigationController alloc] initWithRootViewController:bookVC];
    
    // Create splitView
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    
    splitVC.viewControllers = @[tagsNC, bookNC];
    splitVC.delegate = bookVC;
    
    self.window.rootViewController = splitVC;
    
}

-(void)configureForPhoneWithModel:(POLLibrary*) library{
    
    POLLibraryTableViewController *tagsVC = [[POLLibraryTableViewController alloc] initWithStyle:UITableViewStylePlain
                                                                                           model:library];
    
    // Create navigateControllers
    
    UINavigationController *tagsNC = [[UINavigationController alloc] initWithRootViewController:tagsVC];
    
    
    tagsVC.delegate = tagsVC;
    
    self.window.rootViewController = tagsNC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end