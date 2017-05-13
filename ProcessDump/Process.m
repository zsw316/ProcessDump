//
//  Process.m
//  OCTest
//
//  Created by Shaowei Zhangon 13/5/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "Process.h"

@implementation Process

- (instancetype)initWithName:(NSString*)name children:(NSArray<Process *> *)children {
    if (self = [super init]) {
        _name = name;
        _children = children;
    }
    return self;
}

- (NSUInteger)buildFromStringComponents:(NSArray<NSString *>*)strComponents index:(NSUInteger)index depth:(NSUInteger)depth nameOffset:(NSUInteger)offset {
    NSUInteger componentsCount = strComponents.count;
    NSUInteger curIndex = index;
    
    if (curIndex>=componentsCount) {
        return curIndex;
    }
    
    // Build the name from components[curIndex]
    _name = [[strComponents objectAtIndex:curIndex++] substringFromIndex:offset];
    NSMutableArray *childArray = [[NSMutableArray alloc] init];
    
    NSMutableString *targetPrefixForNonLastChildren = [[NSMutableString alloc] init];
    NSMutableString *targetPrefixForLastChildren = [[NSMutableString alloc] init];
    
    // Append paddings to the prefix
    for (NSUInteger j = 1; j <= depth; j++) {
        [targetPrefixForNonLastChildren appendString:@"│  "];
        [targetPrefixForLastChildren appendString:@"│  "];
    }
    
    // Prefix for non-last child process
    [targetPrefixForNonLastChildren appendString:@"├─ "];
    
    // Prefix for last child process
    [targetPrefixForLastChildren appendString:@"└─ "];
    
    
    while (curIndex<componentsCount) {
        NSString *curString = [strComponents objectAtIndex:curIndex];
        
        // Check if it is non-last child process?
        NSRange range = [curString rangeOfString:targetPrefixForNonLastChildren];
        if (range.location == NSNotFound) {
            range = [curString rangeOfString:targetPrefixForLastChildren];
            if (range.location != NSNotFound) {
                // last child process
                Process *child = [[Process alloc] init];
                curIndex = [child buildFromStringComponents:strComponents index:curIndex depth:depth+1 nameOffset:range.location+range.length];
                [childArray addObject:child];
            }
            
            break;
        }
        else {
            // non-last child process
            Process *child = [[Process alloc] init];
            curIndex = [child buildFromStringComponents:strComponents index:curIndex depth:depth+1 nameOffset:range.location+range.length];
            [childArray addObject:child];
        }
    }
    
    if (childArray.count>0) {
        _children = childArray;
    }
    else {
        _children = nil;
    }
    
    return curIndex;
}

- (void)dump:(NSMutableString*)destStr depth:(NSUInteger)depth {
    
    // Append the name into string
    [destStr appendFormat:@"%@\n", _name];
    NSUInteger childrenNum = _children.count;
    
    for (NSUInteger i =0; i<childrenNum; i++) {
        // Append paddings according to the depth
        for (NSUInteger j = 1; j <= depth; j++) {
            [destStr appendString:@"│  "];
        }
        
        if (i == childrenNum-1) { // The last child process
            [destStr appendString:@"└─ "];
        }
        else { // Non-last child process
            [destStr appendString:@"├─ "];
        }
        
        // Dump the child process recursively
        [_children[i] dump:destStr depth:depth+1];
    }
}

- (instancetype)initFromDumpString:(NSString*)dump {
    
    if (dump) {
        NSArray<NSString *> *components = [dump componentsSeparatedByString:@"\n"];
        
        if (self = [super init]) {
            [self buildFromStringComponents:components index:0 depth:0 nameOffset:0];
        }
        
        return self;
    }
    
    return nil;
}

- (NSString*)dumpInfo {
    NSMutableString *destStr = [[NSMutableString alloc] init];
    [self dump:destStr depth:0];
    return destStr;
}

@end

