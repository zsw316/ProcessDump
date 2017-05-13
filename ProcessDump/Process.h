//
//  Process.h
//  OCTest
//
//  Created by Shaowei Zhang on 13/5/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Process : NSObject

@property (nonatomic) NSString *name;   // process name
@property (nonatomic) NSArray<Process *> *children; // child process

- (instancetype)initWithName:(NSString*)name children:(NSArray<Process *> *)children;

- (instancetype)initFromDumpString:(NSString*)dump;

- (NSString*)dumpInfo;

@end
