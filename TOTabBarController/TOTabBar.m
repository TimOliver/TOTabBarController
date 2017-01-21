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
    _translucent = YES;
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
