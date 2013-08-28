//
//  DetailViewController.h
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PendingQuestionsViewController.h"
#import "Question.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) PendingQuestionsViewController *delegate;
@property (strong, nonatomic) Question *question;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *answeredButton;

- (IBAction)answerQuestion:(id)sender;
@end
