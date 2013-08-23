//
//  Question.h
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import <Parse/Parse.h>

@interface Question : PFObject<PFSubclassing>

@property (retain) NSString *prompt;
@property (retain) NSString *status;

@end
