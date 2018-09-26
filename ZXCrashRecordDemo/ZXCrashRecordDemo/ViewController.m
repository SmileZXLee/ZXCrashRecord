//
//  ViewController.m
//  ZXCrashRecordDemo
//
//  Created by 李兆祥 on 2018/9/23.
//  Copyright © 2018年 李兆祥. All rights reserved.
//

#import "ViewController.h"
#import "ZXCrashRecord.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *crashCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.crashCountLabel.text = [NSString stringWithFormat:@"崩溃次数：%lu",[ZXCrashRecord shareInstance].crashCount];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *array = @[@"0",@"1"];
    NSString *str = array[3];
}
- (IBAction)cleanAction:(id)sender {
    [ZXCrashRecord shareInstance].crashCount = 0;
    self.crashCountLabel.text = [NSString stringWithFormat:@"崩溃次数：%lu",[ZXCrashRecord shareInstance].crashCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
