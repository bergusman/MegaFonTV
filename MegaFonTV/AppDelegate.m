//
//  AppDelegate.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "MenuViewController.h"
#import "GeneralViewController.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    GeneralViewController *generalVC = [[GeneralViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:generalVC];
    self.window.rootViewController = nc;
    
    return YES;
}

@end
