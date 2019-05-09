//
//  JHDatePickerView.m
//  happiness
//
//  Created by jh on 2018/5/9.
//  Copyright © 2018年 jh. All rights reserved.
//


#import "JdatePick.h"

@interface JdatePick ()
{
    CGFloat contentViewHeight;
}
/**
 标题
 */
@property (strong, nonatomic) NSString *title;

/**
 初始化时间
 */
@property (nonatomic, strong) NSDate *date;

/**
 选择后的时间
 */
@property (nonatomic, strong) NSDate *selectDate;
/**
 背景
 */
@property (strong, nonatomic) UIView *backgroundView;

/**
 空间容器
 */
@property (strong, nonatomic) UIView *contentView;
/**
 顶部按钮视图
 */
@property (strong, nonatomic) UIView *buttonView;
/**
 左边按钮
 */
@property (nonatomic, strong) UIButton *leftBtn;
/**
 右边按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;
/**
 标题Label
 */
@property (strong, nonatomic) UILabel *titleLabel;

/**
 时间选择器
 */
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation JdatePick

-(id)initWithTitle:(NSString *)title date:(NSDate *)date{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _date = date;
        _selectDate =date;
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sure)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];
        
        [self initContentView];
        
    }
    return self;
}

- (void)initContentView{
    
    contentViewHeight = 0;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    //按钮视图
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    //设置分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _buttonView.frame.size.height - 1,_buttonView.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_buttonView addSubview:line];
    [_contentView addSubview:_buttonView];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, self.frame.size.width - (80*2), _buttonView.frame.size.height-1)];
    _titleLabel.text = _title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    [_buttonView addSubview:_titleLabel];
    //设置按钮
    //取消
    _leftBtn  =  [self getBtnWithTitle:@"取消"];
    _leftBtn.frame = CGRectMake(0, 0, 80, _buttonView.frame.size.height);
    [_leftBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:_leftBtn];
    //确定
    _rightBtn  =  [self getBtnWithTitle:@"确定"];
    _rightBtn.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, (80), _buttonView.frame.size.height);
    [_rightBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:_rightBtn];
    
    contentViewHeight += _buttonView.frame.size.height;
    //时间选择器
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker setDate:_date];
    // 取得用户默认信息
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    NSArray *languages = [defaults objectForKey : @"AppleLanguages" ];
    //    DLog (@"%@", languages);
    // 获得当前iPhone使用的语言
    NSString* currentLanguage = [languages objectAtIndex:0];
    
    if([currentLanguage isEqualToString:@"en-US"]){
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    }else if ([currentLanguage isEqualToString:@"zh-Hans-US"]){
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    }else{
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];//设置最大时间为：当前时间
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-100];//设置最小时间为：当前时间前推100年
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [_datePicker setMaximumDate:maxDate];
    [_datePicker setMinimumDate:minDate];
    //设置时间模式
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    //设置时区
    [_datePicker setTimeZone:[NSTimeZone localTimeZone]];
    
    _datePicker.hidden = NO;//默认NO
    _datePicker.frame = CGRectMake(0, contentViewHeight, self.frame.size.width, 216);
    //添加点击事件
    [_datePicker addTarget:self action:@selector(datePickerEventValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    contentViewHeight += _datePicker.frame.size.height;
    [_contentView addSubview:_datePicker];
    
    _contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, contentViewHeight);
    [self addSubview:_contentView];
}

#pragma mark 时间选择器 事件
-(void)datePickerEventValueChanged:(UIDatePicker *)datePicker{
    _selectDate = datePicker.date;
}

-(UIButton *)getBtnWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    return btn;
}

#pragma mark 确定点击事件
- (void)sure{
    //判断原始值 与选择的时间是否相等
    if(![_selectDate isEqualToDate:_date]){
        if(self.clickedButton){
            self.clickedButton(_selectDate);
        }
        
    }
    [self hide];
}





- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

- (void)hide {
    [self removeAnimation];
}
- (void)addAnimation {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0.1;
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.3 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
