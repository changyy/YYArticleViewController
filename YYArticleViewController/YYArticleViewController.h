//
//  YYArticleViewViewController.h
//  contentview
//
//  Created by Yuan-Yi Chang on 2014/8/16.
//  Copyright (c) 2014年 Yuan-Yi Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YYArticleView_QUERY_FINISH_DATA_TITLE                   @"title"
#define YYArticleView_QUERY_FINISH_DATA_SUBTITLE                @"subtitle"
#define YYArticleView_QUERY_FINISH_DATA_CONTENT                 @"content"
#define YYArticleView_QUERY_FINISH_DATA_TOOLBAR_BUTTON_ITEMS    @"uitoolbaritems"

@interface YYArticleViewController : UIViewController

@property (nonatomic, strong) UILabel *articleTitle;
@property (nonatomic, strong) UILabel *articleSubtitle;
@property (nonatomic, strong) UITextView *articleContent;
@property (nonatomic, strong) UIToolbar *articleToolbar;
@property (nonatomic, assign) BOOL articleToolbarEnable;
@property (nonatomic, assign) int articleToolbarFixHeightAtiPhone;
@property (nonatomic, assign) int articleToolbarFixHeightAtiPad;

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UITextView *loadingTextView;

- (void)toolbarItemAction:(id)sender;
- (void)initQuery;
- (void)finishQuery:(NSDictionary *)ret;

@end
