//
//  Dice.m
//  Defender benchmark
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 J Osborne. All rights reserved.
//

#import "Dice.h"
#import <Foundation/NSRegularExpression.h>

@interface Dice() {
	int numDice;
	int numSides;
	int constant;
	Dice *moreDice;
    
    bool rolled;
    int lastRoll;
}
@end

@implementation Dice

NSRegularExpression *dice_regex = nil;
dispatch_once_t dice_once;

- (id)initWithString:(NSString *)expression
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    dispatch_once(&dice_once, ^{
        dice_regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+)d(\\d+)(\\+\\d+)$" options:0 error:nil];
        NSAssert(dice_regex, @"made dice regex");
    });
    
    NSTextCheckingResult *match = [dice_regex firstMatchInString:expression options:NSMatchingAnchored range:NSMakeRange(0, [expression length])];
    NSLog(@"'%@' (%@) #ranges=%lu", expression, match, [match numberOfRanges]);
    for(int i = 0; i < [match numberOfRanges]; i++) {
        NSLog(@"R[%d] = '%@'", i, [expression substringWithRange:[match rangeAtIndex:i]]);
    }
    NSAssert(4 == [match numberOfRanges], @"Expected 4 matches, have %lu", [match numberOfRanges]);
    
    numDice =  [[expression substringWithRange:[match rangeAtIndex:1]] intValue];
    numSides = [[expression substringWithRange:[match rangeAtIndex:2]] intValue];
    constant = [[expression substringWithRange:[match rangeAtIndex:3]] intValue];
    moreDice = nil;
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%dd%d%s%d", numDice, numSides, (constant >= 0) ? "+" : "", constant];
}

-(int)value
{
    NSAssert(rolled, @"Call roll before calling value");
    return lastRoll;
}

-(void)roll
{
    rolled = true;
    lastRoll = constant;
    for(int i = 0; i < numDice; i++) {
        lastRoll += 1 + arc4random() % numSides;
    }
}

-(int)max
{
    int m = numSides * numDice + constant;
    if (moreDice) {
        return m + [moreDice max];
    }
    return m;
}

-(double)avg
{
    double a = (1 + numSides) * numDice / 2.0 + constant;
    if (moreDice) {
        a += [moreDice avg];
    }
    return a;
}

@end
