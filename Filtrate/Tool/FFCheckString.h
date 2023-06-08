//
//  FFCheckString.h
//  JuKui
//
//  Created by mac on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFCheckString : NSObject

//验证手机号
+ (BOOL)checkPhoneNumWith:(NSString *)phoneStr;

//验证身份证号
+ (BOOL)checkIdcardCodeWith:(NSString *)codeStr;

//验证全是汉字
+ (BOOL)checkAllChinese:(NSString *)str;

//"带","急","钥","降","淘","举"
+ (BOOL)checkStringIsEqualOneString:(NSString *)str;
//"全","视","限","闪","保"
+ (BOOL)checkStringIsEqualTwoString:(NSString *)str;

//密码  8-10位 数字+密码+特殊符号
+ (BOOL)checkPasswordWith:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
