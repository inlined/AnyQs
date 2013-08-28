//
//  DetailViewController.m
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()<PFLogInViewControllerDelegate>
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setQuestion:(Question *)newQuestion
{
    if (_question != newQuestion) {
        _question = newQuestion;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (IBAction)answerQuestion:(id)sender {
    [self.delegate answerQuestion:self.question sender:self];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.question) {
        self.promptLabel.text = self.question.prompt;
        self.answeredButton.hidden = NO;
    } else {
        self.promptLabel.text = @"That's all folks!";
        self.answeredButton.hidden = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self ensureLoggedIn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ensureLoggedIn {
    
    PFLogInViewController *login = [[PFLogInViewController alloc] init];
    if (![PFUser currentUser]) {
        login.fields = PFLogInFieldsFacebook;
        login.delegate = self;
        [self presentModalViewController:login animated:YES];
    }/* else {
        [self logInViewController:login didLogInUser:PFUser.currentUser];
    }*/
}

- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [self ensureLoggedIn];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self ensureLoggedIn];
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [logInController dismissViewControllerAnimated:YES completion:^{}];
   /*
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSLog(@"Result: %@", result);
    }];*/
    // Yes, this is wasteful
   /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSString *fbid = [PFFacebookUtils userI];
        NSData *profilePic = [NSData dataWithContentsOfURL:nil];
    });*/
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Upcoming", @"Upcoming");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
