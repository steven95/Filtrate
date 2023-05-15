//
//  JuCalendarV.m
//  JuKui
//
//  Created by 挖坑小能手 on 2021/12/9.
//

#import "JuCalendarV.h"
@interface JuCalendarV()<OldHouseDatePickerViewDelegate>
@property (strong, nonatomic)  UIView *beginView;
@property (strong, nonatomic)  UIView *lineV;
@property (strong, nonatomic)  UIView *endView;
@property (nonatomic,strong)   UIView *popBackview;
@property (nonatomic,assign)   BOOL isbegin;
@end

@implementation JuCalendarV


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.beginView];
        [self addSubview:self.beginLabel];
        [self addSubview:self.beginimgV];
        [self addSubview:self.lineV];
        [self addSubview:self.endView];
        [self addSubview:self.endLabel];
        [self addSubview:self.endimgV];
        
        [self.popBackview addSubview:self.chooseDateView];
    }
    return self;
}

-(void)layoutSubviews{
    
    [self.beginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_offset(15);
        make.height.mas_equalTo(30);
    }];
    self.beginView.layer.cornerRadius = 15;
    self.beginLabel.layer.masksToBounds = YES;
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(10);
        make.left.mas_equalTo(self.beginView.mas_right).offset(10);
    }];
    
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(self.lineV.mas_right).offset(10);
        make.right.mas_offset(-15);
        make.width.mas_equalTo(self.beginView.mas_width).priorityHigh();
        make.height.mas_equalTo(30);
    }];
    self.endView.layer.cornerRadius = 15;
    self.endView.layer.masksToBounds = YES;
    
    [self.beginView addSubview:self.beginimgV];

    [self.beginimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.width.height.mas_equalTo(18);
    }];
    
    [self.beginView addSubview:self.beginLabel];
    [self.beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(20);
        make.right.mas_equalTo(self.beginimgV.mas_left).offset(-20);
    }];
    
    [self.endView addSubview:self.endimgV];

    [self.endimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.width.height.mas_equalTo(18);
    }];
    
    [self.endView addSubview:self.endLabel];
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(20);
        make.right.mas_equalTo(self.endimgV.mas_left).offset(-20);
    }];
}


-(void)OnTapBeginView:(UIGestureRecognizer *)tap{
    WEAKSELF
    self.popBackview.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.popBackview];
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.chooseDateView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:nil];
    if (tap.view.tag == 100086) {
        self.isbegin = YES;
        if (self.beginBlock) {
            self.beginBlock(@"");
        }
    }else if (tap.view.tag == 100087){
        self.isbegin = NO;
    }
    if (self.endBlock) {
        self.endBlock(@"");
    }
}

#pragma mark -- OldHouseDatePickerViewDelegate
- (void)cancelChooseDateView
{
    [self cancal];
}

- (void)sureChooseDateViewWithDate:(NSString *)date{
    if (self.isbegin) {
        if (!date) {
            return;
        }
        if ( ![self.endTime isEqualToString:@""] && ![self timeInterval:date andEndTime:self.endTime]) {
            [JuToolsVC showToastString:@"开始日期不能晚于结束日期"];
            return;
        }
        self.beginTime = date;
        self.beginLabel.text = date;
        if (self.beginBlock) {
            self.beginBlock(date);
        }
    }else{
        if (!date) {
            return;
        }
        if (![self.beginTime isEqualToString:@""] && ![self timeInterval:self.beginTime andEndTime:date]  ) {
            [JuToolsVC showToastString:@"结束日期不能早于开始日期"];
            return;
        }
        self.endLabel.text = date;
        self.endTime = date;
        if (self.endBlock) {
            self.endBlock(date);
        }
    }
    [self cancal];
}

-(NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

-(BOOL)timeInterval:(NSString *)beginTime andEndTime:(NSString *)endTime{
    NSLog(@"beginTim%@---",beginTime);
    NSLog(@"endTime:---%@",endTime);
   
    NSDate *beginDate = [self dateFromString:beginTime  withFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [self dateFromString:endTime withFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitDay;
    NSDateComponents *dateCom = [calendar components:unit fromDate:beginDate toDate:endDate options:0];
    NSLog(@"dateCom.day:---%ld",(long)dateCom.day);
    if (dateCom.day >= 0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)cancal{
    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.chooseDateView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        weakSelf.popBackview.hidden = YES;
        [weakSelf.popBackview removeFromSuperview];
    }];
}

-(NSString *)endTime{
    if (!_endTime) {
        _endTime = [NSString string];
    }
    return _endTime;
}

-(NSString *)beginTime{
    if (!_beginTime) {
        _beginTime = [NSString string];
    }
    return _beginTime;
}

- (UIView *)popBackview
{
    if (!_popBackview) {
        _popBackview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _popBackview.backgroundColor = RGBA(0x000000, 0.3);
        [[UIApplication sharedApplication].keyWindow addSubview:_popBackview];
        _popBackview.hidden = YES;
    }
    return _popBackview;
}

-(OldHouseDatePickerView *)chooseDateView{
    if (!_chooseDateView) {
        _chooseDateView = [OldHouseDatePickerView gainOldHouseDatePickerView];
        _chooseDateView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        WEAKSELF
        _chooseDateView.delegate = weakSelf;
    }
    return _chooseDateView;
}


-(UIView *)beginView{
    if (!_beginView) {
        _beginView = [[UIView alloc]init];
        _beginView.backgroundColor = HexRGBAlpha(0xF5F6F7, 1);
        [_beginView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBeginView:)]];
        _beginView.tag = 100086;
    }
    return _beginView;
}

-(UIView *)endView{
    if (!_endView) {
        _endView = [[UIView alloc]init];
        _endView.backgroundColor = HexRGBAlpha(0xF5F6F7, 1);
        [_endView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBeginView:)]];
        _endView.tag = 100087;
    }
    return _endView;
}

-(UILabel *)beginLabel{
    if (!_beginLabel) {
        _beginLabel = [[UILabel alloc]init];
        _beginLabel.text = @"开始时间";
        _beginLabel.textColor = HexRGBAlpha(0xB6BABF, 1);
        _beginLabel.font = [UIFont systemFontOfSize:13];
    }
    return _beginLabel;
}

-(UILabel *)endLabel{
    if (!_endLabel) {
        _endLabel = [[UILabel alloc]init];
        _endLabel.text = @"结束时间";
        _endLabel.textColor = HexRGBAlpha(0xB6BABF, 1);
        _endLabel.font = [UIFont systemFontOfSize:13];
    }
    return _endLabel;
}

-(UIImageView *)beginimgV{
    if (!_beginimgV) {
        _beginimgV = [[UIImageView alloc]init];
        [_beginimgV setImage:[UIImage imageNamed:@"calendar"]];
        _beginimgV.userInteractionEnabled = YES;
    }
    return _beginimgV;
}

-(UIImageView *)endimgV{
    if (!_endimgV) {
        _endimgV = [[UIImageView alloc]init];
        [_endimgV setImage:[UIImage imageNamed:@"calendar"]];
        _endimgV.userInteractionEnabled = YES;
    }
    return _endimgV;
}

-(UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = HexRGBAlpha(0x161C26, 1);
    }
    return _lineV;
}

@end
