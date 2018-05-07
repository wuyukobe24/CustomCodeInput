//
//  CodeInputView.h
//  JDZBorrower
//
//  Created by WangXueqi on 2018/4/20.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCodeBlock)(NSString *);
@interface CodeInputView : UIView
@property(nonatomic,copy)SelectCodeBlock CodeBlock;
@property(nonatomic,assign)NSInteger inputNum;//验证码输入个数（4或6个）
- (instancetype)initWithFrame:(CGRect)frame inputType:(NSInteger)inputNum selectCodeBlock:(SelectCodeBlock)CodeBlock;
@end
