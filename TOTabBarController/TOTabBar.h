//
//  TOTabBar.h
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOTabBar : UIView

/* Items to display */
@property (nonatomic, strong) NSArray<UITabBarItem *> *tabBarItems;

/* Styling */
@property (nonatomic, assign) UIBarStyle barStyle;
@property (nonatomic, assign) BOOL translucent;         // Only applies when the bar is horizontal

/* Vertical Mode Styling */
@property (nonatomic, assign) CGFloat verticalInset;    // For translucent navigation bars
@property (nonatomic, assign) CGFloat verticalPadding;  // For the top and bottom padding
@property (nonatomic, assign) CGFloat verticalItemSpacing; // Between items

/* Horizontal Styling */
@property (nonatomic, assign) CGFloat horizontalPadding; //For the left and right insets
@property (nonatomic, assign) CGFloat horizontalItemSpacing; // When in regular size classes

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, strong, nullable) void (^itemTappedHandler)(NSInteger index, UITabBarItem *item);

@end

NS_ASSUME_NONNULL_END
