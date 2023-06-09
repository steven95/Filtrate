//
//  FFCheckString.m
//  JuKui
//
//  Created by mac on 2021/8/19.
//

#import "FFCheckString.h"

@implementation FFCheckString

//验证手机号
+ (BOOL)checkPhoneNumWith:(NSString *)phoneStr
{
    if (phoneStr.length != 11) {
        return NO;
    }else{
        NSString *regex = @"[0-9]*";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneStr];
        if (!isMatch) {
            return NO;
        }
    }
    return YES;
}

//验证身份证号
+ (BOOL)checkIdcardCodeWith:(NSString *)codeStr
{
    if (codeStr.length == 0) {
        return NO;
    }else{
        NSString *regex = @"(\\d{14}[0-9a-zA-Z])|(\\d{16}[0-9a-zA-Z][0-9])|(\\d{16}[0-9a-zA-Z][X])";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:codeStr];
        if (!isMatch) {
            return NO;
        }
    }
    return YES;
}

//验证全是汉字
+ (BOOL)checkAllChinese:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }else{
        NSString *regex = @"[\u4e00-\u9fa5]+";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:str];
        if (!isMatch) {
            return NO;
        }
    }
    return YES;
}

//"带","急","钥","降","淘","举"
+ (BOOL)checkStringIsEqualOneString:(NSString *)str
{
    NSArray *arr = [NSArray arrayWithObjects:@"带",@"急",@"钥",@"降",@"淘",@"举", nil];
    BOOL isCheck = NO;
    for (NSString *string in arr) {
        if ([string isEqualToString:str]) {
            isCheck = YES;
        }
    }
    return isCheck;
    
}
//"全","视","限","闪","保"
+ (BOOL)checkStringIsEqualTwoString:(NSString *)str
{
    NSArray *arr = [NSArray arrayWithObjects:@"全",@"视",@"限",@"闪",@"保", nil];
    BOOL isCheck = NO;
    for (NSString *string in arr) {
        if ([string isEqualToString:str]) {
            isCheck = YES;
        }
    }
    return isCheck;
}

//密码  8-16位 数字+字母
+ (BOOL)checkPasswordWith:(NSString *)password
{
    if (password.length == 0) {
        return NO;
    }else{
//        8-16位 数字+密码+特殊符号
//        NSString *regex = @"^(?=.*)(?=.*[a-z])(?=.*[~!@#$%^&*:;,.=?$\x22]).{8,16}$";
//        8-16位 数字+字母
        NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:password];
        if (!isMatch) {
            return NO;
        }
    }
    return YES;
}

@end
