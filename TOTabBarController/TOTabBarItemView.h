//
//  TOTabBarItemView.h
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOTabBarItemView : UIView

@property (nonatomic, strong) UITabBarItem *item;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, assign) BOOL showTitle;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat verticalPadding;

- (instancetype)initWithTabBarItem:(UITabBarItem *)tabBarItem;

@end
