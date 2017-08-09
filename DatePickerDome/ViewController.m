//
//  ViewController.m
//  LDatePicker
//
//  Created by 龙青磊 on 2016/11/9.
//  Copyright © 2017年 龙青磊. All rights reserved.
//

#import "ViewController.h"
#import "LDatePicker.h"

@interface ViewController ()<LDatePickerDelegate>
{
    LDatePicker *picker;
}

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    picker = [[LDatePicker alloc]init];
    picker.delegate = self;
    picker.dateMode = UIDatePickerModeDateAndTime;
    picker.allowChoseFuture = NO;
    [self.view addSubview:picker];
    
}

- (IBAction)choseDate:(UIButton *)sender {
    
    [picker showInWindow];
}

- (void)finishSetDateString:(NSString *)str{
    [self.button setTitle:str forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
