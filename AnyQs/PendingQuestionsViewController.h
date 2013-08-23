//
//  MasterViewController.h
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface PendingQuestionsViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
