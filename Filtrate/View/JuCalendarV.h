//
//  JuCalendarV.h
//  JuKui
//
//  Created by 挖坑小能手 on 2021/12/9.
//

#import <UIKit/UIKit.h>
#import "OldHouseDatePickerView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^JuChooseDateBeginBlock) (NSString *date);
typedef void (^JuChooseDateEndBlock) (NSString *date);
@interface JuCalendarV : UIView
//选择日期
@property (nonatomic, strong) OldHouseDatePickerView *chooseDateView;
@property (nonatomic,strong)   JuChooseDateBeginBlock beginBlock;
@property (nonatomic,strong)   JuChooseDateEndBlock endBlock;
@property (strong, nonatomic)  UILabel *endLabel;
@property (strong, nonatomic)  UILabel *beginLabel;
@property (nonatomic,copy)     NSString * beginTime;
@property (nonatomic,copy)     NSString * endTime;
@property (strong, nonatomic)  UIImageView *beginimgV;
@property (strong, nonatomic)  UIImageView *endimgV;
-(void)cancal;
@end

NS_ASSUME_NONNULL_END
