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

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

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
    _verticalPadding = 27.0f;
    _verticalItemSpacing = 40.0f;
    
    _horizontalPadding = 25.0f;
    _horizontalItemSpacing = 70.0f;
    
    _defaultTintColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barTapped:)];
    [self addGestureRecognizer:_tapRecognizer];
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
            itemSpacing = (totalWidth - totalItemWidth) / (self.itemViews.count - 1);
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

#pragma mark - Callbacks -
- (void)barTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    
    // Work out a square size around each item
    CGFloat minSize = MIN(self.bounds.size.width, self.bounds.size.height);
    CGSize tapRegion = (CGSize){minSize, minSize};
    
    // Loop through each item, expand the frame around it to a reasonable
    // tap space, and then check the tap point is inside it
    for (NSInteger i = 0; i < self.itemViews.count; i++) {
        TOTabBarItemView *itemView = self.itemViews[i];
        CGRect frame = itemView.frame;
        
        if (self.isVertical) {
            frame.origin.x = 0.0f;
            frame.size.width = tapRegion.width;
            frame.origin.y = CGRectGetMidY(frame) - 25.0f;
            frame.size.height = 50.0f;
        }
        else {
            frame.origin.y = 0.0f;
            frame.size.height = tapRegion.height;
            frame.origin.x = CGRectGetMidX(frame) - 25.0f;
            frame.size.width = 50.0f;
        }
        
        if (CGRectContainsPoint(frame, point)) {
            self.selectedIndex = i;
            break;
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
        view.tintColor = self.defaultTintColor;
        if (item.image == nil) {
            view.image = self.defaultItemImage;
        }
        [itemViews addObject:view];
        [self addSubview:view];
    }
    
    //set the initial item as selected
    [itemViews.firstObject setTintColor:self.selectedTintColor];
    
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

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    for (TOTabBarItemView *itemView in self.itemViews) {
        itemView.tintColor = self.defaultTintColor;
    }
    self.itemViews[_selectedIndex].tintColor = self.selectedTintColor;
    
    if (self.itemTappedHandler) {
        self.itemTappedHandler(_selectedIndex, self.tabBarItems[_selectedIndex]);
    }
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
