//
//  NSString+rangeOfCharactersFromSet.m
//  Defender benchmark
//
//  Created by J Osborne on 8/25/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "NSString+rangeOfCharactersFromSet.h"
#import <Foundation/Foundation.h>

@implementation NSString (rangeOfCharactersFromSet)

-(NSRange)rangeOfCharactersFromSet:(NSCharacterSet *)aSet options:(NSStringCompareOptions)mask range:(NSRange)aRange
{
    NSAssert(mask & NSAnchoredSearch, @"rangeOfCharactersFromSet only operates with NSAnchoredSearch");
    
    NSRange result = [self rangeOfCharacterFromSet:aSet options:mask range:aRange];
    if (result.length == 0) {
        return result;
    }
    
    for(NSUInteger location = result.location +1; location < aRange.location + aRange.length; location += 1, result.length += 1) {
        if (![aSet characterIsMember:[self characterAtIndex:location]]) {
            break;
        }
    }
    
    return result;
}
@end
