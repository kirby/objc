//
//  GitHubCreateRepo.h
//  ObjectiveCDemo
//
//  Created by Kirby Shabaga on 8/28/14.
//  Copyright (c) 2014 Worxly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubCreateRepo : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *desc;
@property (readonly) NSString *initialize;
@property (readonly) NSString *scope;

-(id)init;
-(id)initWith:(NSString *)name andDescription:(NSString *)desc andAutoInitialize:(NSString *)initialize andScope:(NSString *)scope;

@end
