//
//  LXTextView.h
//  TextKit
//
//  Created by leyikao on 15/6/10.
//  Copyright (c) 2015年 leyikao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTextView : UITextView{
    CGRect textViewRect;
    NSTextStorage *textStroage;
    NSTextContainer *textContainer;
}

@property (strong, nonatomic)UITextView *textView;

@end
