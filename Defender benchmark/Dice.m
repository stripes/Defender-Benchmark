//
//  Dice.m
//  Defender benchmark
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 J Osborne. All rights reserved.
//

#import "Dice.h"
#import "NSString+rangeOfCharactersFromSet.h"

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

NSCharacterSet *integers;
dispatch_once_t dice_once;

- (id)initWithString:(NSString *)expression
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    dispatch_once(&dice_once, ^{
        integers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSAssert(integers, @"made integers char set");
    });
    
    NSRange numDiceRange = [expression rangeOfCharactersFromSet:integers options:NSAnchoredSearch range:NSMakeRange(0, [expression length])];
    NSAssert(numDiceRange.length != 0, @"Expected '%@' to start with digits", expression);
    int number = [[expression substringWithRange:numDiceRange] intValue];
    if (numDiceRange.length == [expression length]) {
        constant = number;
    } else {
        numDice = number;
        NSAssert('d' == [expression characterAtIndex:numDiceRange.length], @"Expected d to follow first digits in %@", expression);
        NSAssert(numDiceRange.length <= [expression length], @"Expected digits after first d in %@", expression);
        NSRange numSidesRange = [expression rangeOfCharactersFromSet:integers options:NSAnchoredSearch range:NSMakeRange(numDiceRange.length +1, [expression length] - (numDiceRange.length +1))];
        NSAssert(numSidesRange.length != 0, @"Expected '%@' to have digits after the d", expression);
        numSides = [[expression substringWithRange:numSidesRange] intValue];
        
        if (numSidesRange.location + numSidesRange.length != [expression length]) {
            NSUInteger nextExpressionLocation = numSidesRange.location + numSidesRange.length;
            NSAssert('+' == [expression characterAtIndex:nextExpressionLocation], @"Expected + after number of sides, or empty string in '%@', not %c", expression, (char)[expression characterAtIndex:nextExpressionLocation]);
            moreDice = [[Dice alloc] initWithString:[expression substringFromIndex:nextExpressionLocation +1]];
        } else {
            moreDice = nil;
        }
    }
    
    return self;
}

-(NSString *)description
{
    if (numDice) {
        NSAssert(constant == 0, @"Can't have a constant and numDice");
        return [NSString stringWithFormat:@"%dd%d%s%@", numDice, numSides, (moreDice != nil) ? "+" : "", moreDice ? [moreDice description] : @""];
    } else {
        return [NSString stringWithFormat:@"%d%s%@", constant, (moreDice != nil) ? "+" : "", moreDice ? [moreDice description] : @""];
    }
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
    if (moreDice) {
        [moreDice roll];
        lastRoll += [moreDice value];
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
