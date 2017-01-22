//
//  TOTabBarItemView.m
//  TOTabBarControllerExample
//
//  Created by Tim Oliver on 1/21/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOTabBarItemView.h"

@interface TOTabBarItemView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TOTabBarItemView

- (instancetype)initWithTabBarItem:(UITabBarItem *)tabBarItem
{
    if (self = [self initWithFrame:CGRectZero]) {
        _item = tabBarItem;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _verticalPadding = 6.0f;
    }
    
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    if (self.imageView.superview == nil) {
        [self addSubview:self.imageView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.imageView.frame;
    rect.origin.y = 0.0f;
    rect.origin.x = CGRectGetMidX(self.bounds) - (CGRectGetWidth(rect) * 0.5f);
    self.imageView.frame = rect;
    
    rect = self.titleLabel.frame;
    rect.origin.y = CGRectGetMaxY(self.imageView.frame) + self.verticalPadding;
    rect.origin.x = CGRectGetMidX(self.bounds) - (CGRectGetWidth(rect) * 0.5f);
    self.titleLabel.frame = rect;
}

- (void)sizeToFit {
    [super sizeToFit];
    
    if (self.titleLabel) {
        [self.titleLabel sizeToFit];
    }
    
    CGRect frame = self.frame;
    frame.size = self.imageView.image.size;
    
    if (self.showTitle) {
        CGRect titleLabelFrame = self.titleLabel.frame;
        
        frame.size.height += self.verticalPadding;
        frame.size.height += titleLabelFrame.size.height;
        
        if (CGRectGetWidth(titleLabelFrame) > CGRectGetWidth(frame)) {
            frame.size.width = CGRectGetWidth(titleLabelFrame);
        }
    }
    
    self.frame = frame;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    if (!self.selected || !self.selectedImage) {
        self.imageView.image = _image;
        [self.imageView sizeToFit];
        [self setNeedsLayout];
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    
    if (self.selected) {
        self.imageView.image = _selectedImage;
        [self setNeedsLayout];
    }
}

- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageView];
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (self.showTitle == NO) {
        return nil;
    }
    
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:_titleLabel];
    return _titleLabel;
}

@end
