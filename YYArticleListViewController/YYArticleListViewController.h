//
//  YYArticleListViewController.h
//  Drafts
//
//  Created by Yuan-Yi Chang on 2014/8/17.
//  Copyright (c) 2014年 Yuan-Yi Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYArticleListViewController : UITableViewController

@property (nonatomic, strong) NSAttributedString *titleForPullToRefresh;
@property (nonatomic, strong) NSAttributedString *titleForLoading;

@end
