//
//  AppDelegate.m
//  ReduxDemo
//
//  Created by bob on 2019/2/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DemoViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}



@end
