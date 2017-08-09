//
//  LDatePicker.h
//  LDatePickerDome
//
//  Created by 龙青磊 on 2016/11/9.
//  Copyright © 2017年 龙青磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDatePickerDelegate <NSObject>

/**  选中时间后的代理返回   */
- (void)finishSetDateString:(NSString *)str;

@end

@interface LDatePicker : UIView

@property (nonatomic, weak)id<LDatePickerDelegate> delegate;

//设置选择器显示的样式 默认情况下显示 UIDatePickerModeTime
@property (nonatomic, assign) UIDatePickerMode dateMode;

//设置选择器是否能够选择现在往后的时间 （比如生日的选择只能选择当前时间之前） 默认值为YES
@property(nonatomic, assign) BOOL allowChoseFuture;

//时间选择器的展示
- (void)showInWindow;

@end
