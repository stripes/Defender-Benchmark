//
//  Defender_benchmarkTests.m
//  Defender benchmarkTests
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 Apple. All rights reserved.
//

#import "Defender_benchmarkTests.h"
#import "Dice.h"

@implementation Defender_benchmarkTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testDice
{
    Dice *d6 = [[Dice alloc] initWithString:@"1d6+0"];
    
    STAssertEquals(6, [d6 max], @"Higest roll of 1d6 should be 6");
    STAssertEquals(3.5, [d6 avg], @"Avg roll of 1d6 sjould be 3.5");
    double total = 0;
    const int rolls = 1000;
    
    for(int i = 0; i < rolls; i++) {
        [d6 roll];
        STAssertTrue([d6 value] <= 6, @"d6 roll was %d, expected <= 6", [d6 value]);
        STAssertTrue([d6 value] >= 1, @"d6 roll was %d, expected >= 1", [d6 value]);
        total += [d6 value];
    }
    
    STAssertEqualsWithAccuracy(total / rolls, [d6 avg], 0.05, @"unexpected actual avg");
}

@end
