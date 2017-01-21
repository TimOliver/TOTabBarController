//
//  AppDelegate.m
//  TOTabBarController
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "AppDelegate.h"

#import "TOTabBarController.h"
#import "TOTabViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) TOTabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] init];
    
    self.tabBarController = [[TOTabBarController alloc] init];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self setUpViewControllers];
    
    return YES;
}

- (void)setUpViewControllers
{
    NSMutableArray *controllers = [NSMutableArray array];
    
    // First
    TOTabViewController *firstController = [[TOTabViewController alloc] initWithIndex:1];
    UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:firstController];
    [controllers addObject:firstNavController];
    
    [firstNavController pushViewController:[UIViewController new] animated:NO];
    
    // Second
    TOTabViewController *secondController = [[TOTabViewController alloc] initWithIndex:2];
    UINavigationController *secondNavController = [[UINavigationController alloc] initWithRootViewController:secondController];
    [controllers addObject:secondNavController];
    
    // Third
    TOTabViewController *thirdController = [[TOTabViewController alloc] initWithIndex:3];
    UINavigationController *thirdNavController = [[UINavigationController alloc] initWithRootViewController:thirdController];
    [controllers addObject:thirdNavController];
    
    // Fourth
    TOTabViewController *fourthController = [[TOTabViewController alloc] initWithIndex:4];
    UINavigationController *fourthNavController = [[UINavigationController alloc] initWithRootViewController:fourthController];
    [controllers addObject:fourthNavController];
    
    // Fifth
    TOTabViewController *fifthController = [[TOTabViewController alloc] initWithIndex:5];
    UINavigationController *fifthNavController = [[UINavigationController alloc] initWithRootViewController:fifthController];
    [controllers addObject:fifthNavController];
    
    self.tabBarController.viewControllers = [NSArray arrayWithArray:controllers];
}

@end
