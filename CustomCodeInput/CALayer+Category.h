//
//  CALayer+Category.h
//  CustomCodeInput
//
//  Created by WangXueqi on 2018/5/7.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Category)
+ (CALayer *)addSubLayerWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)color
                         backView:(UIView *)baseView;
@end
