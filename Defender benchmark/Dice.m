//
//  Dice.m
//  Defender benchmark
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "Dice.h"
#import <Foundation/NSRegularExpression.h>

@implementation Dice

NSRegularExpression *dice_regex = nil;
dispatch_once_t dice_once;

- (id)init
{
    self = [super init];
    if (self) {
        dispatch_once(&dice_once, ^{
            dice_regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+)d(\\d+)(\\+\\d+)$" options:0 error:nil];
            NSAssert(dice_regex, @"made dice regex");
        });
        // ...
    }
    
    return self;
}

@end
