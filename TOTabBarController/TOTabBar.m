//
//  TOTabBar.m
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOTabBar.h"
#import "TOTabBarItemView.h"

@interface TOTabBar()

@property (nonatomic, strong) NSArray<TOTabBarItemView *> *itemViews;

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
    _verticalPadding = 30.0f;
    _verticalItemSpacing = 40.0f;
    
    _horizontalPadding = 25.0f;
    _horizontalItemSpacing = 70.0f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat separatorSize = 1.0f / [[UIScreen mainScreen] scale];
    
    // Layout the separator
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
    
    // Size the items
    for (TOTabBarItemView *itemView in self.itemViews) {
        [itemView sizeToFit];
    }
    
    // Layout vertically
    if (self.isVertical) {
        CGFloat y = self.verticalInset + self.verticalPadding;
        for (TOTabBarItemView *itemView in self.itemViews) {
            frame = itemView.frame;
            frame.origin.x = CGRectGetMidX(self.bounds) - (CGRectGetWidth(frame) * 0.5f);
            frame.origin.y = y;
            itemView.frame = frame;
            
            y += frame.size.height + self.verticalItemSpacing;
        }
    }
    else { // Layout horizontally
        CGFloat totalItemWidth = 0.0f;
        CGFloat totalWidth = 0.0f;
        CGFloat x = 0.0f;
        CGFloat itemSpacing = 0.0f;
        
        for (TOTabBarItemView *itemView in self.itemViews) {
            totalItemWidth += itemView.frame.size.width;
        }
        
        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            totalWidth = self.frame.size.width - (self.horizontalPadding * 2.0f);
            itemSpacing = totalWidth / totalItemWidth;
            x = self.horizontalPadding;
        }
        else {
            totalWidth = totalItemWidth + (self.horizontalItemSpacing * (self.itemViews.count - 1));
            itemSpacing = self.horizontalItemSpacing;
            x = CGRectGetMidX(self.bounds) - (totalWidth * 0.5f);
        }
        
        for (TOTabBarItemView *itemView in self.itemViews) {
            frame = itemView.frame;
            frame.origin.x = x;
            frame.origin.y = CGRectGetMidY(self.bounds) - (frame.size.height * 0.5f);
            itemView.frame = frame;
            
            x += frame.size.width + itemSpacing;
        }
    }
}

#pragma mark - Accessors -

- (void)setTabBarItems:(NSArray<UITabBarItem *> *)tabBarItems
{
    if (tabBarItems == _tabBarItems) {
        return;
    }
    
    // Remove any previous buttons
    if (self.itemViews.count) {
        for (TOTabBarItemView *view in self.itemViews) {
            [view removeFromSuperview];
        }
        self.itemViews = nil;
    }
    
    _tabBarItems = tabBarItems;
    
    // Create new item views
    NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:_tabBarItems.count];
    for (UITabBarItem *item in _tabBarItems) {
        TOTabBarItemView *view = [[TOTabBarItemView alloc] initWithTabBarItem:item];
        if (item.image == nil) {
            view.image = self.defaultItemImage;
        }
        [itemViews addObject:view];
        [self addSubview:view];
    }
    
    self.itemViews = [NSArray arrayWithArray:itemViews];
    [self setNeedsLayout];
}

- (BOOL)isVertical
{
    return self.frame.size.width < self.frame.size.height;
}

- (BOOL)shouldBeTranslucent
{
    return self.translucent && !self.isVertical;
}

- (UIImage *)defaultItemImage
{
    if (_defaultItemImage) {
        return _defaultItemImage;
    }
    
    UIGraphicsBeginImageContextWithOptions((CGSize){28,28}, NO, 0.0f);
    
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 27, 27)];
    [UIColor.blackColor setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _defaultItemImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return _defaultItemImage;
}

@end
