//
//  TOTabViewController.m
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOTabViewController.h"

@interface TOTabViewController ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TOTabViewController

- (instancetype)initWithIndex:(NSInteger)index
{
    if (self = [super init]) {
        self.tabBarItem.title = [NSString stringWithFormat:@"VC %ld", (long)index];
        self.index = index;
        self.title = [NSString stringWithFormat:@"View Controller %ld", (long)index];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.text = [NSString stringWithFormat:@"View Controller %ld", (long)self.index];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:25.0f];
    self.label.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    self.label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.label sizeToFit];
    [self.view addSubview:self.label];
    
    self.label.center = (CGPoint){CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)};
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
}

@end
