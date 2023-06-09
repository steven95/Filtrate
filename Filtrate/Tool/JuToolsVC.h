//
//  JuToolsVC.h
//
//  Created by yu on 2020/3/6.
//  Copyright © 2020 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void(^okBlock)(NSString *phone);
@interface JuToolsVC : UIViewController
/**
 * 提示框
 */
+ (void)showToastString:(NSString *)string;
+ (void)showToastViewString:(NSString *)string callphone:(okBlock)phone ;
@end

@interface ToastLabel : UILabel
+ (ToastLabel *) sharedToastLabel;
@end

@interface ToastView : UIView
+ (ToastView *) sharedToastView;
@end

@interface ToastInputText : UITextField
+ (ToastInputText *) sharedToastInputText;

@end


NS_ASSUME_NONNULL_END
