//
//  KAAppDelegate.m
//  KAPieChart
//
//  Created by Kenneth Parker Ackerson on 11/17/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAAppDelegate.h"
#import "KAViewController.h"
@implementation KAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    KAViewController * viewController = [[KAViewController alloc] initWithNibName:nil bundle:nil];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
