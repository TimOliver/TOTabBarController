//
//  TOTabBar.m
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOTabBar.h"

@interface TOTabBar()

@property (nonatomic, strong) UIVisualEffectView *visualEffectsView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, readonly) BOOL isVertical;
@property (nonatomic, readonly) BOOL shouldBeTranslucent;

@property (nonatomic, strong) UIImage *defaultItemImage;

@end

@implementation TOTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    self.separatorView = [[UIView alloc] init];
    self.separatorView.backgroundColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
    [self addSubview:self.separatorView];
    
    _translucent = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat separatorSize = 1.0f / [[UIScreen mainScreen] scale];
    
    CGRect frame = CGRectZero;
    if (self.isVertical) {
        frame.origin.x = CGRectGetMaxX(self.bounds) - separatorSize;
        frame.size.width = separatorSize;
        frame.size.height = CGRectGetHeight(self.bounds);
    }
    else {
        frame.size.height = separatorSize;
        frame.size.width = CGRectGetWidth(self.bounds);
    }
    self.separatorView.frame = frame;
}

#pragma mark - Accessors -

- (void)setTabBarItems:(NSArray<UITabBarItem *> *)tabBarItems
{
    if (tabBarItems == _tabBarItems) {
        return;
    }
    
    _tabBarItems = tabBarItems;
    
    
}

- (BOOL)isVertical
{
    return self.frame.size.width < self.frame.size.height;
}

- (BOOL)shouldBeTranslucent
{
    return self.translucent && !self.isVertical;
}

@end
