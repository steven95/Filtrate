//
//  UIView+FFExtension.h
//  JuKui
//
//  Created by mac on 2021/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FFExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

//四边阴影
- (void)addRoundShadowwithColor:(UIColor *)color;
//上边阴影
- (void)addTopShadowWithColor:(UIColor *)color;
//下边阴影
- (void)addBottomShadowWithViewHeight:(CGFloat)viewHeight withColor:(UIColor *)color;

//切四个圆角
- (void)addRoundRadiusWithRadius:(CGFloat)radius;
//切上边俩圆角
- (void)addTopRadiusWithRadius:(CGFloat)radius withViewWidth:(CGFloat)viewWidth;
//切下边俩圆角
- (void)addBottomRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth;
//切左边俩圆角
- (void)addLeftRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth;
//切右边俩圆角
- (void)addRightRadiusWithRadius:(CGFloat)readius withViewHeight:(CGFloat)viewHeight withViewWidth:(CGFloat)viewWidth;

@end

NS_ASSUME_NONNULL_END
