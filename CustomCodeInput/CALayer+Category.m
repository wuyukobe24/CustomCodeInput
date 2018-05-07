//
//  CALayer+Category.m
//  CustomCodeInput
//
//  Created by WangXueqi on 2018/5/7.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "CALayer+Category.h"

@implementation CALayer (Category)
+ (CALayer *)addSubLayerWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)color
                         backView:(UIView *)baseView
{
    CALayer * layer = [[CALayer alloc]init];
    layer.frame = frame;
    layer.backgroundColor = [color CGColor];
    [baseView.layer addSublayer:layer];
    return layer;
}
@end
