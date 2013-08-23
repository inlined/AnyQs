//
//  Question.m
//  AnyQs
//
//  Created by Thomas Bouldin on 8/23/13.
//  Copyright (c) 2013 Thomas Bouldin. All rights reserved.
//

#import "Question.h"
#import <Parse/PFObject+Subclass.h>

@implementation Question : PFObject

@dynamic prompt;
@dynamic status;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Question";
}
@end
