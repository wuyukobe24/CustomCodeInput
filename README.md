# CustomCodeInput
自定义验证码输入框（4位或6位）

效果图：

![输入框](https://github.com/wuyukobe24/CustomCodeInput/blob/master/test.gif)
### 基本思路：
* 自定义输入框视图底部放置一个textView，并设置成透明色，目的是用于点击textView可以弹出数字键盘，并且可以获取到输入的数字。
* 在textView的上面循环（循环的次数根据验证码的位数来决定，如4位或6位）创建一组四个控件，分别是：View、Layer、Label和ShapeLayer，并且Layer、Label和ShapeLayer要添加到View上。Layer是底部放置输入框数字的横线，Label是展示输入的数字，ShapeLayer是闪动的光标。
```
- (void)initSubviews {
    CGFloat W = CGRectGetWidth(self.frame);
    CGFloat H = CGRectGetHeight(self.frame);
    CGFloat Padd = (K_Screen_Width-self.inputNum*K_W)/(self.inputNum+1);
    [self addSubview:self.textView];
    self.textView.frame = CGRectMake(Padd, 0, W-Padd*2, H);
    //默认编辑第一个.
    [self beginEdit];
    for (int i = 0; i < _inputNum; i ++) {
        UIView *subView = [UIView new];
        subView.frame = CGRectMake(Padd+(K_W+Padd)*i, 0, K_W, H);
        subView.userInteractionEnabled = NO;
        [self addSubview:subView];
        [CALayer addSubLayerWithFrame:CGRectMake(0, H-2, K_W, 2) backgroundColor:[UIColor lightGrayColor] backView:subView];
        //Label
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, K_W, H);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:38];
        [subView addSubview:label];
        //光标
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(K_W / 2, 15, 2, H - 30)];
        CAShapeLayer *line = [CAShapeLayer layer];
        line.path = path.CGPath;
        line.fillColor =  [UIColor darkGrayColor].CGColor;
        [subView.layer addSublayer:line];
        if (i == 0) {
            [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
            //高亮颜色
            line.hidden = NO;
        }else {
            line.hidden = YES;
        }
        //把光标对象和label对象装进数组
        [self.lines addObject:line];
        [self.labels addObject:label];
    }
}
```
* 把创建的光标对象ShapeLayer和Label对象装进数组，用于后面在输入框输入数字时切换其显示还是隐藏的属性。
* 在textView的代理方法- (void)textViewDidChange:(UITextView *)textView；中去获取输入框输入的内容，并截取对应的数字放到对应创建的Label上进行显示，而光标则根据当前位置上的Label上文本内容的有无来设置光标的隐藏和显示，即如果该位置Label上无数字，则光标显示出来并闪动，反之则隐藏。
```
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *verStr = textView.text;
    if (verStr.length > _inputNum) {
        textView.text = [textView.text substringToIndex:_inputNum];
    }
    //大于等于最大值时, 结束编辑
    if (verStr.length >= _inputNum) {
        [self endEdit];
    }
    if (self.CodeBlock) {
        self.CodeBlock(textView.text);
    }
    for (int i = 0; i < _labels.count; i ++) {
        UILabel *bgLabel = _labels[i];
        
        if (i < verStr.length) {
            [self changeViewLayerIndex:i linesHidden:YES];
            bgLabel.text = [verStr substringWithRange:NSMakeRange(i, 1)];
        }else {
            [self changeViewLayerIndex:i linesHidden:i == verStr.length ? NO : YES];
            //textView的text为空的时候
            if (!verStr && verStr.length == 0) {
                [self changeViewLayerIndex:0 linesHidden:NO];
            }
            bgLabel.text = @"";
        }
    }
}
//光标显示或者隐藏
- (void)changeViewLayerIndex:(NSInteger)index linesHidden:(BOOL)hidden {
    CAShapeLayer *line = self.lines[index];
    if (hidden) {
        [line removeAnimationForKey:@"kOpacityAnimation"];
    }else{
        [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
    }
    [UIView animateWithDuration:0.25 animations:^{
        line.hidden = hidden;
    }];
}
```
光标闪动动画为：
```
//闪动动画
- (CABasicAnimation *)opacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.9;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}
```
