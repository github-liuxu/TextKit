//
//  LXTextView.m
//  TextKit
//
//  Created by leyikao on 15/6/10.
//  Copyright (c) 2015年 leyikao. All rights reserved.
//

#import "LXTextView.h"

@implementation LXTextView

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    _textView = self;
    return self;
}

- (void)configTextView{
    //构建view的CGRect范围
    textViewRect = CGRectInset(self.bounds, 10.0, 10.0);
    //    初始化NSTextStorage对象需要字符串
    textStroage = [[NSTextStorage alloc]initWithString:_textView.text];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [textStroage addLayoutManager:layoutManager];
    textContainer = [[NSTextContainer alloc]initWithSize:textViewRect.size];
    [layoutManager addTextContainer:textContainer];
}

- (void)reloadTextView{
    [_textView removeFromSuperview];
    _textView = [[UITextView alloc]initWithFrame:textViewRect textContainer:textContainer];
//    [self.view insertSubview:_textView belowSubview:_imageView];
//    [_imageView removeFromSuperview];
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
//        NSRange mmrang = {matchRange.location+index,matchRange.length};
//        [textStroager addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:mmrang];
                [textStroager replaceCharactersInRange:matchRange withString:@""];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed: @"123.png"];
        textAttachment.bounds = CGRectMake(0, 0, 30, 30);
        NSAttributedString *attrStrs = [NSAttributedString attributedStringWithAttachment: textAttachment];
        [textStroager insertAttributedString: attrStrs atIndex:matchRange.location];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
