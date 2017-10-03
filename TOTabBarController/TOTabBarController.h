//
//  TOTabBarController.h
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOTabBar;

NS_ASSUME_NONNULL_BEGIN

@interface TOTabBarController : UIViewController

/* The view controllers managed by this tab bar controller */
@property (nonatomic, copy) NSArray *viewControllers;

/* The tab bar that controls transitioning between view controllers */
@property (nonatomic, readonly) TOTabBar *tabBar;

/* A main call-to-action button placed in the tab bar that allows specific actions */
@property (nonatomic, strong) UIButton *tabBarButton;

/* When the bar is horizontal, the vertical padding the button has from the bottom */
@property (nonatomic, assign) CGFloat horizontalBarButtonOffset;

/* The currently selected tab bar index. Can be used to programmatically switch view controllers */
@property (nonatomic, assign) NSUInteger selectedIndex;

/* The currently visible view controller. Can be used to programmatically switch view controllers */
@property (nonatomic, weak) UIViewController *visibleViewController;

/* Keeps the tab bar at the bottom of the screen in regular size classes */
@property (nonatomic, assign) BOOL tabBarIsAlwaysHorizontal;

/* When the bar is horiztonal, its height (Default is 44) */
@property (nonatomic, assign) CGFloat horizontalTabBarHeight;

/* When the bar is vertical, its width (Default is 54) */
@property (nonatomic, assign) CGFloat verticalTabBarWidth;

@end

@protocol TOTabBarControllerDelegate <NSObject>

- (BOOL)tabBarController:(TOTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(TOTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

- (BOOL)tabBarController:(TOTabBarController *)tabBarController shouldShowTabBarButtonForTraitCollection:(UITraitCollection *)traitCollection;
- (void)tabBarController:(TOTabBarController *)tabBarController didTapTabBarButton:(UIButton *)button;

@end

@interface UIViewController (TOTabBarController)

- (TOTabBarController *)TO_tabBarController;

@end

NS_ASSUME_NONNULL_END
