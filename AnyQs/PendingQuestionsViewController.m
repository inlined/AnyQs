//
//  PendingQuestionsViewController.m
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import "PendingQuestionsViewController.h"

#import "DetailViewController.h"

@interface PendingQuestionsViewController()
@property NSMutableArray *objects;

- (Question *)objectAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PendingQuestionsViewController
@dynamic objects; // in super

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.parseClassName = @"Question";
        self.textKey = @"prompt";
    }
    return self;
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    if (!error && [self.objects count] >= 1 && !self.detailViewController.question) {
        self.detailViewController.question = [self objectAtIndex:0];
    }
}

- (Question *)objectAtIndex:(int) index {
    return (Question *)[self.objects objectAtIndex:index];
}

- (Question *)objectAtIndexPath:(NSIndexPath *)indexPath {
    return (Question *)[super objectAtIndexPath:indexPath];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [super queryForTable];
    [query whereKey:@"status" equalTo:@"accepted"];
    return query;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-  (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    Question *q = (Question *)[self objectAtIndexPath:indexPath];
    self.detailViewController.question = q;
}

- (void)answerQuestion:(Question *)question sender:(id)sender {
    question.status = @"answered";
    [question saveInBackground];
    
    int index = -1;
    // indexForObject doesn't work for some reason;
    for (int n = 0 ; n < self.objects.count; ++n) {
        if ([[self.objects[n] objectId] isEqualToString:question.objectId]) {
            index = n;
            break;
        }
    }
    
    // Update the data store without a new query
    [self.objects removeObjectAtIndex:index];
    [self objectsWillLoad];
    [self.tableView reloadData];
    
    // update the detail view
    if ([self.objects count] == 0) {
        self.detailViewController.question = nil;
    } else {
        if (index >= [self.objects count]) {
            index = 0;
        }
        self.detailViewController.question = self.objects[index];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setQuestion:[self objectAtIndexPath:indexPath]];
    }
}

@end
