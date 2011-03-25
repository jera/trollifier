//
//  main.m
//  Trollifier
//
//  Created by Thiago Moretto on 25/03/11.
//  Copyright Jera Software Agil 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"TrollifierAppDelegate");
    [pool release];
    return retVal;
}
