//
//  JuToolsVC.m
//
//  Created by yu on 2020/3/6.
//  Copyright © 2020 yu. All rights reserved.
//

#import "JuToolsVC.h"
#import "FFCheckString.h"

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                         green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                         blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define SCALE ([UIScreen mainScreen].bounds.size.width/375.0)

@interface JuToolsVC()
@property (nonatomic,copy) okBlock calphone;
@end

@implementation JuToolsVC

/**
 * 提示框
 */
+ (void)showToastString:(NSString *)string
{
    if ([string isKindOfClass:[NSError class]]) {
        string = @"发生错误了，工程师正在赶来";
    }
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToastString:string];
        });
        return;
    }
    
    UILabel *toastLab = [ToastLabel sharedToastLabel];
    
    [[[UIApplication sharedApplication] delegate].window addSubview:toastLab];
    if (toastLab.superview != [[UIApplication sharedApplication] delegate].window)
    {
        [toastLab removeFromSuperview];
        [[[UIApplication sharedApplication] delegate].window addSubview:toastLab];
    }
    toastLab.numberOfLines = 2;
    toastLab.text = string;
    toastLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    toastLab.backgroundColor = [UIColor blackColor];
    toastLab.textColor = [UIColor whiteColor];
    CGSize size = [toastLab.text sizeWithAttributes:@{NSFontAttributeName:toastLab.font}];//304*SCALE
    toastLab.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-size.width/2-15*SCALE, [UIScreen mainScreen].bounds.size.height/2, size.width+30*SCALE, size.height + 20);
    
    toastLab.layer.cornerRadius = 5.0f;
    toastLab.layer.masksToBounds = YES;
    [UIView animateWithDuration: 1 animations:^{
        toastLab.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            [toastLab removeFromSuperview];
            toastLab.alpha = 0;
        }];
    }];
}
/**
 * 提示框
 */
+ (void)showToastViewString:(NSString *)string callphone:(okBlock)phone
{
    if ([string isKindOfClass:[NSError class]]) {
        string = @"发生错误了，工程师正在赶来";
    }
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToastString:string];
        });
        return;
    }
    
    ToastView *toastView = [ToastView sharedToastView];
    toastView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIView * carldView = [[UIView alloc] initWithFrame:CGRectMake(45, [[UIApplication sharedApplication] delegate].window.center.y - 102 ,[UIScreen mainScreen].bounds.size.width - 90 , 204)];
    carldView.backgroundColor = [UIColor whiteColor];
    toastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [toastView addSubview:carldView];
    UILabel *titleL =  [[UILabel alloc]initWithFrame:CGRectMake((carldView.bounds.size.width - 100) / 2, 24, 100, 25)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = string;
    titleL.textColor = [UIColor blackColor];
    titleL.font = [UIFont systemFontOfSize:18];
    [carldView addSubview:titleL];
    
    UIButton * hubutton = [[UIButton alloc]initWithFrame:CGRectMake(carldView.bounds.size.width - 50, 18 , 31, 31)];
    [hubutton addTarget:self action:@selector(click_hub) forControlEvents:UIControlEventTouchUpInside];
    [hubutton setImage:[UIImage imageNamed:@"hud"] forState:UIControlStateNormal];
    [carldView addSubview:hubutton];
    
    UILabel *descL =  [[UILabel alloc]initWithFrame:CGRectMake((carldView.bounds.size.width - 160) / 2, 54, 160, 25)];
    descL.textAlignment = NSTextAlignmentCenter;
    descL.text = @"我们会着专人为您服务";
    descL.textColor = HexRGBAlpha(0x85888C, 1);
    descL.font = [UIFont systemFontOfSize:14];
    [carldView addSubview:descL];
    
    UITextField * inputText = [ToastInputText sharedToastInputText] ;
    inputText.frame = CGRectMake(25, 93, carldView.bounds.size.width - 50, 41);
    inputText.backgroundColor = HexRGBAlpha(0xECECEC, 1);
    inputText.keyboardType =  UIKeyboardTypePhonePad;
    inputText.placeholder = @"请输入您的电话号码";
    [carldView addSubview:inputText];
    
    UIButton * gobutton = [[UIButton alloc]initWithFrame:CGRectMake(100,carldView.bounds.size.height - 45 , carldView.bounds.size.width - 200, 25)];
    [gobutton addTarget:self action:@selector(click_go) forControlEvents:UIControlEventTouchUpInside];
    [gobutton setTitle:@"立即预约" forState:UIControlStateNormal];
    gobutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [gobutton setTitleColor:HexRGBAlpha(0xFC3D4B, 1) forState:UIControlStateNormal];
    [carldView addSubview:gobutton];
    
    [[[UIApplication sharedApplication] delegate].window addSubview:toastView];
    [[UIApplication sharedApplication] delegate].window.windowLevel = UIWindowLevelAlert + 1;
    if (toastView.superview != [[UIApplication sharedApplication] delegate].window)
    {
        [toastView removeFromSuperview];
        [[[UIApplication sharedApplication] delegate].window addSubview:toastView];
    }

    carldView.layer.cornerRadius = 10;
    carldView.layer.masksToBounds = YES;
    [UIView animateWithDuration:0.3 animations:^{
        toastView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
      
    [JuToolsVC shared].calphone  = phone;

}

+(void)click_go{

    if  (![FFCheckString checkPhoneNumWith:[ToastInputText sharedToastInputText].text]) {
        [JuToolsVC showToastString:@"请输入正确的手机号"];
    }else{
        [JuToolsVC shared].calphone([ToastInputText sharedToastInputText].text);
        [JuToolsVC click_hub];
    }
}


+(void)click_hub{
    
    [UIView animateWithDuration:0.3 animations:^{
        [ToastView sharedToastView].alpha = 0;
    } completion:^(BOOL finished) {
        [ToastInputText sharedToastInputText].text = @"";
        [[ToastInputText sharedToastInputText] removeFromSuperview];
        [[ToastView sharedToastView] removeFromSuperview];
    }];
}

static JuToolsVC *toast = nil;

+ (JuToolsVC *)shared
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (toast == nil)
        {
            toast = [[self alloc] init];
        }
    });
    return toast;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end


static ToastLabel *toastLab = nil;
@implementation ToastLabel
+ (ToastLabel *)sharedToastLabel
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (toastLab == nil)
        {
            toastLab = [[self alloc] init];
            toastLab.textColor = [UIColor whiteColor];
            toastLab.textAlignment = NSTextAlignmentCenter;
            toastLab.backgroundColor = [UIColor blackColor];
            toastLab.lineBreakMode = NSLineBreakByCharWrapping;
        }
    });
    return toastLab;
}

@end

static ToastView *toastView = nil;
@implementation ToastView
+ (ToastView *)sharedToastView
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (toastView == nil)
        {
            toastView = [[self alloc] init];
            toastView.backgroundColor = [UIColor whiteColor];
        }
    });
    return toastView;
}

@end
static ToastInputText *toastInputText = nil;
@implementation ToastInputText
+ (ToastInputText *)sharedToastInputText
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (toastInputText == nil)
        {
            toastInputText = [[self alloc] init];
        }
    });
    return toastInputText;
}

@end


