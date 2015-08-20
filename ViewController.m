//
//  ViewController.m
//  TextKit
//
//  Created by leyikao on 15/6/8.
//  Copyright (c) 2015年 leyikao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTextView];
    [self reloadTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configTextView{
    //构建view的CGRect范围
    textViewRect = CGRectInset(self.view.bounds, 10.0, 10.0);
    //    初始化NSTextStorage对象需要字符串
    textStroage = [[NSTextStorage alloc]initWithString:_textView.text];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [textStroage addLayoutManager:layoutManager];
    _textContainer = [[NSTextContainer alloc]initWithSize:textViewRect.size];
    [layoutManager addTextContainer:_textContainer];
}

- (void)reloadTextView{
    [_textView removeFromSuperview];
    _textView = [[UITextView alloc]initWithFrame:textViewRect textContainer:_textContainer];
    [self.view insertSubview:_textView belowSubview:_imageView];
    [_imageView removeFromSuperview];
    [textStroage beginEditing];
    NSDictionary *attrsDic = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:_textView.text attributes:attrsDic];
    [textStroage setAttributedString:attrStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [textStroage addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _textView.text.length)];
    [textStroage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize: 17.0f] range:NSMakeRange(0, _textView.text.length)];
    [self markWorld:@"a" InTextStroage:textStroage];
    [textStroage endEditing];
}

- (void)markWorld:(NSString*)text InTextStroage:(NSTextStorage*)textStroager{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:text options:0 error:nil];
    NSArray *matches = [regex matchesInString:_textView.text options:0 range:NSMakeRange(0, [_textView.text length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSRange mmrang = {matchRange.location+index,matchRange.length};
        [textStroager addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:mmrang];
//        [textStroager replaceCharactersInRange:matchRange withString:@""];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed: @"123.png"];
        textAttachment.bounds = CGRectMake(0, 0, 30, 30);
        NSAttributedString *attrStrs = [NSAttributedString attributedStringWithAttachment: textAttachment];
        [textStroager insertAttributedString: attrStrs atIndex:mmrang.location];
        
        index++;
    }
}

- (UIBezierPath*)translatedBezierPath{
    CGRect imageRect = [self.textView convertRect:_imageView.frame fromView:self.view];
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:5.0];
    return newPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
