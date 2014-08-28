//
//  GitHubCreateRepo.m
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/28/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import "GitHubCreateRepo.h"

@implementation GitHubCreateRepo

-(id)init {
    self = [super init];
    return self;
}

-(id)initWith:(NSString *)name andDescription:(NSString *)desc andAutoInitialize:(NSString *)initialize andScope:(NSString *)scope {
    self = [super init];
    if (self) {
        _name = name;
        _desc = desc;
        _initialize = initialize;
        _scope = scope;
    }
    return self;
}

@end
