//
//  OldHouseDatePickerView.h
//  JuKui
//
//  Created by mac on 2021/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OldHouseDatePickerViewDelegate <NSObject>

@required

- (void)cancelChooseDateView;

@optional

- (void)sureChooseDateViewWithDate:(NSString *)date;

- (void)sureChooseDateViewWithDate:(NSString *)date withIndex:(NSIndexPath *)indexPath;

- (void)sureChooseDateViewWithDate:(NSString *)date withIsBegin:(BOOL)isBegin;

@end

@interface OldHouseDatePickerView : UIView

//选择年份
@property (nonatomic, assign) BOOL isChooseYear;

+ (instancetype)gainOldHouseDatePickerView;

@property (nonatomic, weak) id<OldHouseDatePickerViewDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) NSInteger dateType;

@end

NS_ASSUME_NONNULL_END
