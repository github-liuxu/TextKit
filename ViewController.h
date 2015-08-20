//
//  ViewController.h
//  TextKit
//
//  Created by leyikao on 15/6/8.
//  Copyright (c) 2015年 leyikao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int index;
    CGRect textViewRect;
    NSTextStorage *textStroage;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic)NSTextContainer *textContainer;

@end

