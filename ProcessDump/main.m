//
//  main.m
//  ProcessDump
//
//  Created by Shaowei Zhang on 13/5/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Process.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Process* xcode = [[Process alloc] initWithName:@"Xcode"
                                              children:@[[[Process alloc] initWithName:@"Simulator"
                                                                              children:@[[[Process alloc] initWithName:@"iPhone 7" children:nil],
                                                                                         [[Process alloc] initWithName:@"iPad" children:nil]]],
                                                         [[Process alloc] initWithName:@"Debugger" children:nil]]];
        Process* finder = [[Process alloc] initWithName:@"Finder" children:nil];
        Process* facebook = [[Process alloc] initWithName:@"Facebook" children:nil];
        
        Process* launcher = [[Process alloc] initWithName:@"Launcher" children:@[xcode, finder, facebook]];
        NSString *dumpString = [launcher dumpInfo];
        
        NSLog(@"Dump info: \n%@", dumpString);
        NSLog(@"Dump info: \n%@", [[[Process alloc] initFromDumpString:dumpString] dumpInfo]);
    }
    
    return 0;
}
