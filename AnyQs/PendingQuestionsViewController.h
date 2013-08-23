//
//  PendingQuestionsViewController.h
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Question.h"

@class DetailViewController;

@interface PendingQuestionsViewController : PFQueryTableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

- (void)answerQuestion:(Question *)question sender:(id)sender;
@end
