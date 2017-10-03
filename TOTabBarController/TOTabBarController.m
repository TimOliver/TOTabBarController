//
//  TOTabBarController.m
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOTabBarController.h"
#import "TOTabBar.h"

@interface TOTabBarController ()

@property (nonatomic, readonly) BOOL tabBarIsHorizontal;

@property (nonatomic, strong, readwrite) TOTabBar *tabBar;

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, weak) UINavigationController *childNavigationController;

@end

@implementation TOTabBarController

#pragma mark - Class Creation -
- (instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    _horizontalTabBarHeight = 50.0f;
    _verticalTabBarWidth = 86.0f;
}

#pragma mark - View Creation -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    // View Configuration
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Tab Bar Configuration
    self.tabBar = [[TOTabBar alloc] initWithFrame:CGRectZero];
    self.tabBar.itemTappedHandler = ^(NSInteger index, UITabBarItem *item) {
        [weakSelf tabBarTappedAtIndex:index forItem:item];
    };
    [self.view addSubview:self.tabBar];
    
    self.navigationBar = [[UINavigationBar alloc] init];
    self.navigationBar.hidden = YES;
    [self.view addSubview:self.navigationBar];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutTabBar];
    [self layoutChildViewController];
    [self layoutNavigationBar];
}

- (void)layoutTabBar
{
    BOOL horizontalLayout = self.tabBarIsHorizontal;
    CGRect frame = CGRectZero;
    CGSize viewSize = self.view.bounds.size;
    
    if (horizontalLayout) {
        frame.origin.y = viewSize.height - self.horizontalTabBarHeight;
        frame.size.height = self.horizontalTabBarHeight;
        frame.size.width = viewSize.width;
        [self.view bringSubviewToFront:self.tabBar];
    }
    else {
        frame.size.width = self.verticalTabBarWidth;
        frame.size.height = viewSize.height;
        [self.view sendSubviewToBack:self.tabBar];
    }
    
    self.tabBar.frame = frame;
}

- (void)layoutChildViewController
{
    CGRect tabBarRect = self.tabBar.frame;
    BOOL tabBarIsVertical = !self.tabBarIsHorizontal;
    
    CGSize parentSize = self.view.bounds.size;
    
    CGRect viewRect = CGRectZero;
    viewRect.origin.x = tabBarIsVertical ? CGRectGetMaxX(tabBarRect) : 0.0f;
    viewRect.origin.y = 0.0f;
    viewRect.size.height = parentSize.height;
    if (!tabBarIsVertical && !self.tabBar.translucent) {
        viewRect.size.height -= CGRectGetHeight(self.tabBar.frame);
    }
    viewRect.size.width = parentSize.width;
    if (tabBarIsVertical) {
        viewRect.size.width -=CGRectGetWidth(self.tabBar.frame);
    }
    
    self.visibleViewController.view.frame = viewRect;
}

- (void)layoutNavigationBar
{
    if (self.tabBarIsHorizontal) {
        self.navigationBar.hidden = YES;
        return;
    }
    
    self.navigationBar.hidden = NO;
    
    CGRect rect = CGRectZero;
    if (self.childNavigationController) {
        rect.size.width = CGRectGetWidth(self.tabBar.frame);
        rect.size.height = CGRectGetMaxY(self.childNavigationController.navigationBar.frame);
    }
    else {
        rect.size.width = self.view.frame.size.width;
        rect.size.height = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    self.navigationBar.frame = rect;
    
    self.tabBar.verticalInset = rect.size.height;
}

#pragma mark - View Controller Transition -
- (void)transitionToViewControllerForIndex:(NSUInteger)index
{
    // Remove old view controller
    if (self.visibleViewController) {
        [self.visibleViewController willMoveToParentViewController:nil];
        [self.visibleViewController removeFromParentViewController];
        [self.visibleViewController.view removeFromSuperview];
        [self.visibleViewController didMoveToParentViewController:nil];
    }

    // Save the new view controller
    UIViewController *newController = self.viewControllers[index];
    _visibleViewController = newController;
    
    // Add new view controller
    [newController willMoveToParentViewController:self];
    [self addChildViewController:newController];
    [self.view addSubview:newController.view];
    [newController didMoveToParentViewController:self];
    
    // Capture if any of the children is a navigation controller
    self.childNavigationController = nil;
    UIViewController *controller = newController;
    do {
        if ([controller isKindOfClass:[UINavigationController class]]) {
            self.childNavigationController = (UINavigationController *)controller;
            break;
        }
        
    } while ((controller = controller.childViewControllers.firstObject));
}

#pragma mark - Button Callbacks -
- (void)tabBarTappedAtIndex:(NSInteger)index forItem:(UITabBarItem *)item
{
    self.selectedIndex = index;
}

#pragma mark - Accessors -
- (void)setViewControllers:(NSArray *)viewControllers
{
    if (viewControllers == _viewControllers) {
        return;
    }
    
    // Attach the first view controller to the screen
    _viewControllers = [viewControllers copy];
    [self transitionToViewControllerForIndex:0];
    
    //Collect the tab bar items and forward them to the tab bar
    NSMutableArray *tabBarItems = [NSMutableArray array];
    for (UIViewController *controller in _viewControllers) {
        [tabBarItems addObject:controller.tabBarItem];
    }
    self.tabBar.tabBarItems = [NSArray arrayWithArray:tabBarItems];
}

- (void)setVisibleViewController:(UIViewController *)visibleViewController
{
    NSInteger index = [self.viewControllers indexOfObject:visibleViewController];
    if (index == NSNotFound ) {
        return;
    }
    
    self.selectedIndex = index;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex == _selectedIndex) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    if (_selectedIndex >= self.viewControllers.count) {
        _selectedIndex = self.viewControllers.count - 1;
    }
    
    [self transitionToViewControllerForIndex:_selectedIndex];
}

- (void)setTabBarButton:(UIButton *)tabBarButton
{
    self.tabBar.button = tabBarButton;
}

- (UIButton *)tabBarButton
{
    return self.tabBar.button;
}

#pragma mark - Accessors -
- (BOOL)tabBarIsHorizontal
{
    BOOL isCompact = self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact;
    return isCompact || self.tabBarIsAlwaysHorizontal;
}

@end
