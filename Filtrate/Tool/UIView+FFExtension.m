//
//  UIView+FFExtension.m
//  JuKui
//
//  Created by mac on 2021/9/8.
//

#import "UIView+FFExtension.h"

@implementation UIView (FFExtension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

//四边阴影
- (void)addRoundShadowwithColor:(UIColor *)color
{
    // 阴影颜色
    self.layer.shadowColor = color.CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,2);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    self.layer.shadowRadius = 3;
}

//上边阴影
- (void)addTopShadowWithColor:(UIColor *)color
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    
    float shadowPathWidth = self.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, 0, self.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

//下边阴影
- (void)addBottomShadowWithViewHeight:(CGFloat)viewHeight withColor:(UIColor *)color
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 3;
    
    float shadowPathWidth = self.layer.shadowRadius;
    CGRect shadowRect = CGRectMake(0, viewHeight, self.bounds.size.width, shadowPathWidth);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

//切四个圆角
- (void)addRoundRadiusWithRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
//切上边俩圆角
- (void)addTopRadiusWithRadius:(CGFloat)radius withViewWidth:(CGFloat)viewWidth
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewWidth, 1000) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//切下边俩圆角
- (void)addBottomRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewWidth, viewHeight) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(readius, readius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//切左边俩圆角
- (void)addLeftRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewWidth, viewHeight) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(readius, readius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
//切右边俩圆角
- (void)addRightRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewWidth, viewHeight) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(readius, readius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
