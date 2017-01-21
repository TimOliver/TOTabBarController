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

@property (nonatomic, assign) UIBarStyle barStyle;
@property (nonatomic, assign) BOOL translucent; // Only applies when the bar is horizontal

@property (nonatomic, strong) NSArray<UITabBarItem *> *tabBarItems;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, strong, nullable) void (^itemTappedHandler)(NSInteger index, UITabBarItem *item);

@end

NS_ASSUME_NONNULL_END
