//
//  YYArticleViewViewController.m
//  contentview
//
//  Created by Yuan-Yi Chang on 2014/8/16.
//  Copyright (c) 2014年 Yuan-Yi Chang. All rights reserved.
//

#import "YYArticleViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface YYArticleViewController ()
@property (nonatomic, assign) int fontBaseSize;
@property (nonatomic, assign) int statusBarHeight;
@property (nonatomic, assign) int navigactionControllerHeight;
@property (nonatomic, assign) int navigactionToolbarHeight;
@property (nonatomic, assign) int articleToolbarHeight;
@property (nonatomic, assign) CGSize loadingSize;

@end

@implementation YYArticleViewController

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UILabel *)articleTitle
{
    if (!_articleTitle)
        _articleTitle = [[UILabel alloc] init];
    return _articleTitle;
}

- (UILabel *)articleSubtitle
{
    if (!_articleSubtitle)
        _articleSubtitle = [[UILabel alloc] init];
    return _articleSubtitle;
}

- (UITextView *)articleContent
{
    if (!_articleContent)
        _articleContent = [[UITextView alloc] init];
    return _articleContent;
}

- (UIToolbar *)articleToolbar
{
    if (!_articleToolbar) {
        _articleToolbar = [[UIToolbar alloc] init];
    }
    return _articleToolbar;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.4];
        _activityIndicatorView.layer.masksToBounds = YES;
    }
    return _activityIndicatorView;
}

- (UITextView *)loadingTextView
{
    if (!_loadingTextView)
        _loadingTextView = [[UITextView alloc] init];
    return _loadingTextView;
}

#pragma makr - view event

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return !UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self setupLayout];
}

/*
- (UIStatusBarStyle)preferredStatusBarStyle
 {
    return UIStatusBarStyleLightContent;
}
 */

#pragma mark - event

- (void)toolbarItemAction:(id)sender
{
    
}

- (void)initQuery
{
    self.isLoading = YES;
    [self setupLayout];
}

- (void)finishQuery:(NSDictionary *)ret
{
    if (ret) {
        if (ret[YYArticleView_QUERY_FINISH_DATA_TITLE]) {
            if ([ret[YYArticleView_QUERY_FINISH_DATA_TITLE] isKindOfClass:[NSAttributedString class]])
                self.articleTitle.attributedText = ret[YYArticleView_QUERY_FINISH_DATA_TITLE];
            else if ([ret[YYArticleView_QUERY_FINISH_DATA_TITLE] isKindOfClass:[NSString class]])
                self.articleTitle.text = ret[YYArticleView_QUERY_FINISH_DATA_TITLE];
        }
        if (ret[YYArticleView_QUERY_FINISH_DATA_SUBTITLE]) {
            if ([ret[YYArticleView_QUERY_FINISH_DATA_SUBTITLE] isKindOfClass:[NSAttributedString class]])
                self.articleSubtitle.attributedText = ret[YYArticleView_QUERY_FINISH_DATA_SUBTITLE];
            else if ([ret[YYArticleView_QUERY_FINISH_DATA_SUBTITLE] isKindOfClass:[NSString class]])
                self.articleSubtitle.text = ret[YYArticleView_QUERY_FINISH_DATA_SUBTITLE];
        }
        if (ret[YYArticleView_QUERY_FINISH_DATA_CONTENT]) {
            if ([ret[YYArticleView_QUERY_FINISH_DATA_CONTENT] isKindOfClass:[NSAttributedString class]])
                self.articleContent.attributedText = ret[YYArticleView_QUERY_FINISH_DATA_CONTENT];
            else if ([ret[YYArticleView_QUERY_FINISH_DATA_CONTENT] isKindOfClass:[NSString class]])
                self.articleContent.text = ret[YYArticleView_QUERY_FINISH_DATA_CONTENT];
        }
        self.articleToolbarEnable = NO;
        if (ret[YYArticleView_QUERY_FINISH_DATA_TOOLBAR_BUTTON_ITEMS] && [ret[YYArticleView_QUERY_FINISH_DATA_TOOLBAR_BUTTON_ITEMS] isKindOfClass:[NSArray class]]) {
            self.articleToolbar.items = nil;
            for (id item in [ret[YYArticleView_QUERY_FINISH_DATA_TOOLBAR_BUTTON_ITEMS] allObjects]) {
                if ([item isKindOfClass:[UIBarButtonItem class]]) {
                    [item addTarget:self action:@selector(toolbarItemAction:) forControlEvents:UIControlEventTouchDown];
                }
            }
            self.articleToolbar.items = ret[YYArticleView_QUERY_FINISH_DATA_TOOLBAR_BUTTON_ITEMS];
            if ([self.articleToolbar.items count]) {
                self.articleToolbarEnable = YES;
            }
        }
    }
    self.isLoading = NO;
    [self setupLayout];
}

#pragma mark - view init

- (void)setupLayout
{
    CGSize totalScreenSize = CGSizeZero;
    BOOL deviceLandscapeMode = NO;
    
    // Step 0: check rotation
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        totalScreenSize = CGSizeMake( [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width );
        deviceLandscapeMode = YES;
    } else {
        totalScreenSize = [[UIScreen mainScreen] bounds].size;
    }
    //NSLog(@"totalScreenSize: %@", NSStringFromCGSize(totalScreenSize));
    
    // Step 1: check device
    switch ([UIDevice currentDevice].userInterfaceIdiom) {
        case UIUserInterfaceIdiomPhone:
        {
            self.fontBaseSize = 20;
            if (self.articleToolbarEnable) {
                self.articleToolbarHeight = self.articleToolbarFixHeightAtiPhone > 0 ? self.articleToolbarFixHeightAtiPhone : 44;
            } else
                self.articleToolbarHeight = 0;
            self.loadingSize = CGSizeMake(60, 60);
            self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            self.activityIndicatorView.layer.cornerRadius = 10;

        }
            break;
        case UIUserInterfaceIdiomPad:
        default:
        {
            self.fontBaseSize = 40;
            if (self.articleToolbarEnable) {
                self.articleToolbarHeight = self.articleToolbarFixHeightAtiPad ? self.articleToolbarFixHeightAtiPad : 60;
            } else
                self.articleToolbarHeight = 0;
            self.loadingSize = CGSizeMake(175, 175);
            self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            self.activityIndicatorView.layer.cornerRadius = 25;

            //self.loadingView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }
            break;
    }
    
    // Step 2: check status bar
    if ([UIApplication sharedApplication].statusBarHidden) {
        self.statusBarHeight = 0;
    } else {
        self.statusBarHeight = deviceLandscapeMode ? [UIApplication sharedApplication].statusBarFrame.size.width : [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    // Step 3: check nav & uitoolbar
    if (!self.navigationController) {
        self.navigactionControllerHeight = 0;
        self.navigactionToolbarHeight = 0;
    } else {
        self.navigactionControllerHeight = self.navigationController.navigationBar.frame.size.height;
        if (self.navigationController.toolbarHidden)
            self.navigactionToolbarHeight = 0;
        else
            self.navigactionToolbarHeight = self.navigationController.toolbar.frame.size.height;
    }
    
    [self.activityIndicatorView removeFromSuperview];
    [self.loadingTextView removeFromSuperview];
    if (self.isLoading) {
        self.activityIndicatorView.frame = CGRectMake(totalScreenSize.width/2 - self.loadingSize.width/2, totalScreenSize.height/2 - self.loadingSize.height/2, self.loadingSize.width, self.loadingSize.height);
        [self.activityIndicatorView startAnimating];
        if ([self.loadingTextView.text length]) {
            if (CGSizeEqualToSize(CGSizeZero, self.loadingTextView.frame.size)) {
                self.loadingTextView.frame = CGRectMake(self.activityIndicatorView.frame.origin.x, self.activityIndicatorView.frame.origin.y + self.activityIndicatorView.frame.size.height, self.activityIndicatorView.frame.size.width, self.fontBaseSize);
                self.loadingTextView.font = [UIFont systemFontOfSize:self.fontBaseSize/2];
                self.loadingTextView.textAlignment = NSTextAlignmentCenter;
                self.loadingTextView.backgroundColor = [UIColor clearColor];
            } else {
                self.loadingTextView.frame = CGRectMake(self.activityIndicatorView.frame.origin.x + (self.activityIndicatorView.frame.size.width - self.loadingTextView.frame.size.width), self.activityIndicatorView.frame.origin.y + self.activityIndicatorView.frame.size.height/2, self.loadingTextView.frame.size.width, self.loadingTextView.frame.size.height);
            }
            [self.view addSubview:self.loadingTextView];
        }
        [self.view addSubview:self.activityIndicatorView];
    } else {
        [self.activityIndicatorView stopAnimating];
        
        CGSize targetSize = CGSizeZero;
        // Step 4: fill article title
        self.articleTitle.font = [UIFont systemFontOfSize:self.fontBaseSize + 4];
        self.articleTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.articleTitle.numberOfLines = 0;
        targetSize = [self.articleTitle sizeThatFits:totalScreenSize];
        self.articleTitle.frame = CGRectMake(0, self.statusBarHeight + self.navigactionControllerHeight, targetSize.width, targetSize.height);
        [self.articleTitle removeFromSuperview];
        [self.view addSubview:self.articleTitle];
        //NSLog(@"articleTitle frame: %@", NSStringFromCGRect(self.articleTitle.frame));
        
        // Step 5: fill article subtitle
        self.articleSubtitle.font = [UIFont systemFontOfSize:self.fontBaseSize - 8];
        self.articleSubtitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.articleSubtitle.numberOfLines = 0;
        targetSize = [self.articleSubtitle sizeThatFits:totalScreenSize];
        self.articleSubtitle.frame = CGRectMake(0, self.statusBarHeight + self.navigactionControllerHeight + self.articleTitle.frame.size.height, targetSize.width, targetSize.height);
        [self.articleSubtitle removeFromSuperview];
        [self.view addSubview:self.articleSubtitle];
        //NSLog(@"articleSubtitle frame: %@", NSStringFromCGRect(self.articleSubtitle.frame));
        
        // Step 6: fill uitoolbar
        self.articleToolbar.frame = CGRectMake(0, totalScreenSize.height - self.navigactionToolbarHeight - self.articleToolbarHeight, totalScreenSize.width, self.articleToolbarHeight);
        [self.articleToolbar removeFromSuperview];
        [self.view addSubview:self.articleToolbar];
        //NSLog(@"self.articleToolbar.frame:%@", NSStringFromCGRect(self.articleToolbar.frame));
        
        // Step 7: fill article content
        self.articleContent.frame = CGRectMake(0, self.statusBarHeight + self.navigactionControllerHeight + self.articleTitle.frame.size.height + self.articleSubtitle.frame.size.height, totalScreenSize.width, totalScreenSize.height - (self.statusBarHeight + self.navigactionControllerHeight + self.articleTitle.frame.size.height + self.articleSubtitle.frame.size.height + self.articleToolbar.frame.size.height + self.navigactionToolbarHeight));
        self.articleContent.font = [UIFont systemFontOfSize:self.fontBaseSize];
        self.articleContent.editable = NO;
        [self.articleContent removeFromSuperview];
        [self.view addSubview:self.articleContent];
        //NSLog(@"articleContent frame: %@", NSStringFromCGRect(self.articleContent.frame));
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupLayout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
