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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        _verticalPadding = 6.0f;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.imageView.frame;
    rect.origin = CGPointZero;
    self.imageView.frame = rect;
    
    rect = self.titleLabel.frame;
    
}

- (void)sizeToFit {
    [super sizeToFit];
    
    CGRect rect = self.imageView.frame;
    rect.size = self.imageView.image.size;
    
    if (self.titleLabel) {
        [self.titleLabel sizeToFit];
    }
    
    CGRect frame = self.frame;
    frame.size.height = self.imageView.image.size.height;
    if (self.showTitle) {
        frame.size.height += self.verticalPadding;
        frame.size.height += self.titleLabel.frame.size.height;
    }
    
    self.frame = rect;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    if (!self.selected || !self.selectedImage) {
        self.imageView.image = _image;
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
