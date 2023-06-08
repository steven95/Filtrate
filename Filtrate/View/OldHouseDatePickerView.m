//
//  OldHouseDatePickerView.m
//  JuKui
//
//  Created by mac on 2021/9/16.
//

#import "OldHouseDatePickerView.h"
#import "UIView+FFExtension.h"
@interface OldHouseDatePickerView ()<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *cancelView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)cancelBtnClick:(id)sender;
- (IBAction)sureBtnClick:(id)sender;

@end


@implementation OldHouseDatePickerView

- (void)setDateType:(NSInteger)dateType
{
    _dateType = dateType;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

+ (instancetype)gainOldHouseDatePickerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"OldHouseDatePickerView" owner:self options:nil].lastObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_backView addTopRadiusWithRadius:8 withViewWidth:[UIScreen mainScreen].bounds.size.width];
    [_cancelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelViewClick)]];
}

- (IBAction)sureBtnClick:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:_datePicker.date];
    NSLog(@"%@", dateStr);
    
    if (_dateType) {
        if ([self.delegate respondsToSelector:@selector(sureChooseDateViewWithDate:withIsBegin:)]) {
            if (_dateType == 1) {
                [self.delegate sureChooseDateViewWithDate:dateStr withIsBegin:YES];
            }else{
                [self.delegate sureChooseDateViewWithDate:dateStr withIsBegin:NO];
            }
        }
    }else{
        if (_indexPath) {
            if ([self.delegate respondsToSelector:@selector(sureChooseDateViewWithDate:withIndex:)]) {
                [self.delegate sureChooseDateViewWithDate:dateStr withIndex:_indexPath];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(sureChooseDateViewWithDate:)]) {
                [self.delegate sureChooseDateViewWithDate:dateStr];
            }
        }
    }
}

- (IBAction)cancelBtnClick:(id)sender {
    [self cancelViewClick];
}
- (void)cancelViewClick
{
    if ([self.delegate respondsToSelector:@selector(cancelChooseDateView)]) {
        [self.delegate cancelChooseDateView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
