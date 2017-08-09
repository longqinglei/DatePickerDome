//
//  LDatePicker.m
//  LDatePickerDome
//
//  Created by 龙青磊 on 2016/11/9.
//  Copyright © 2017年 龙青磊. All rights reserved.
//

#import "LDatePicker.h"

#define kWinH [[UIScreen mainScreen] bounds].size.height
#define kWinW [[UIScreen mainScreen] bounds].size.width

#define LDatePickerH 200
#define LDatePickerToolViewH 46

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1]

@interface LDatePicker()

@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation LDatePicker

- (instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, kWinH, kWinW, kWinH)];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark - 初始化
- (void)initSubviews{//初始化选择器需要的所有控件
    
    // 1.设置当前View(蒙板)属性
    [self setCurrentViewAttrubute];
    
    // 2.创建选择器
    [self creartPickerView];
    
    // 3.创建工具条
    [self creatPickerToolView];
    
}

- (void)setCurrentViewAttrubute{//设置View的相关属性
    
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidClick:)];
    [self addGestureRecognizer:tapGesture];    
    
}

- (void)creartPickerView{//创建PickerView
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kWinH - LDatePickerH, kWinW, LDatePickerH)];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
        _datePicker.datePickerMode = self.dateMode;
        _datePicker.userInteractionEnabled = YES;
        [self addSubview:_datePicker];
    }
}

- (void)setDateMode:(UIDatePickerMode)dateMode{
    _dateMode = dateMode;
    _datePicker.datePickerMode = dateMode;
}

- (void)setAllowChoseFuture:(BOOL)allowChoseFuture{
    if (!allowChoseFuture) {
        _datePicker.maximumDate = [NSDate date];
    }
}

- (void)creatPickerToolView{//创建PickerView的工具条
    
    UIView *constaintView = [[UIView alloc] init];
    constaintView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1].CGColor;
    constaintView.layer.borderWidth = 1;
    constaintView.frame = CGRectMake(-2, kWinH - LDatePickerH - LDatePickerToolViewH, kWinW + 2, LDatePickerToolViewH);
    constaintView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self addSubview:constaintView];
    
    UIButton *buttonFinish = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonFinish.frame = CGRectMake(kWinW - 80, 0, 60, LDatePickerToolViewH);
    buttonFinish.backgroundColor = [UIColor clearColor];
    [buttonFinish setTitleColor:RGBCOLOR(255, 153, 67) forState:UIControlStateNormal];
    [buttonFinish setTitle:@"完成" forState:UIControlStateNormal];
    [buttonFinish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [constaintView addSubview:buttonFinish];
    
    UIButton *buttonCanle = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCanle.frame = CGRectMake(15, 0, 60, LDatePickerToolViewH);
    buttonCanle.backgroundColor = [UIColor clearColor];
    [buttonCanle setTitleColor:RGBCOLOR(255, 153, 67) forState:UIControlStateNormal];
    [buttonCanle setTitle:@"取消" forState:UIControlStateNormal];
    [buttonCanle addTarget:self action:@selector(canleAction:) forControlEvents:UIControlEventTouchUpInside];
    [constaintView addSubview:buttonCanle];
}

#pragma mark - 时间选择
- (void)changeDate:(UIDatePicker *)sender{
    _datePicker.date = sender.date;
}

#pragma mark - 展示/移除在window上
- (void)showInWindow{
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -kWinH);
    } completion:^(BOOL finished) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];

    }];
}

- (void)removeFromWindow{
    
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 按钮点击时间
- (void)finishAction:(UIButton *)btn{//完成按钮点击
    NSDate *pickerDate = [_datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    if ( self.dateMode == UIDatePickerModeTime){
        [pickerFormatter setDateFormat:@"HH:mm"];
    }else if ( self.dateMode == UIDatePickerModeDate ) {
        [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    }else if (self.dateMode == UIDatePickerModeDateAndTime) {
        [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    [self.delegate finishSetDateString:dateString];
    
    [self removeFromWindow];
}

- (void)canleAction:(UIButton *)btn{//取消按钮点击事件
    [self removeFromWindow];
}

- (void)tapDidClick:(UITapGestureRecognizer *)tapGesture{//点击View
    [self removeFromWindow];
}


@end
