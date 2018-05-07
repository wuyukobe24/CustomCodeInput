//
//  ViewController.m
//  CustomCodeInput
//
//  Created by WangXueqi on 2018/5/7.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "ViewController.h"
#import "CodeInputView.h"

@interface ViewController ()
@property(nonatomic,strong)CodeInputView * codeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.codeView];
}

- (CodeInputView *)codeView {
//    __weak typeof(self) selfWeak = self;
    if (!_codeView) {
        _codeView = [[CodeInputView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80) inputType:4 selectCodeBlock:^(NSString * code) {
            NSLog(@"code === %@",code);
        }];
        _codeView.center = self.view.center;
    }
    return _codeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
