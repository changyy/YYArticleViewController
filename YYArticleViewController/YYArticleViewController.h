//
//  YYArticleViewViewController.h
//  contentview
//
//  Created by Yuan-Yi Chang on 2014/8/16.
//  Copyright (c) 2014年 Yuan-Yi Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYArticleViewController : UIViewController

@property (nonatomic, strong) UILabel *articleTitle;
@property (nonatomic, strong) UILabel *articleSubtitle;
@property (nonatomic, strong) UITextView *articleContent;
@property (nonatomic, strong) UIToolbar *articleToolbar;
@property (nonatomic, assign) BOOL articleToolbarEnable;
@property (nonatomic, assign) int articleToolbarFixHeightAtiPhone;
@property (nonatomic, assign) int articleToolbarFixHeightAtiPad;

@end
