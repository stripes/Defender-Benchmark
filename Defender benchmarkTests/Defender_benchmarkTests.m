//
//  Defender_benchmarkTests.m
//  Defender benchmarkTests
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 J Osborne. All rights reserved.
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

- (void)testOneDieSix
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
    
    STAssertEqualsWithAccuracy(total / rolls, [d6 avg], 0.1, @"unexpected actual avg");
    STAssertEqualObjects(@"1d6+0", [d6 description], @"wrong description?");
}

-(void)testOneDieSixPlusTwo
{
    Dice *d6plus2 = [[Dice alloc] initWithString:@"1d6+2"];
    
    STAssertEquals(8, [d6plus2 max], @"Higest roll of 1d6 should be 8");
    STAssertEquals(5.5, [d6plus2 avg], @"Avg roll of 1d6 sjould be 5.5");
    double total = 0;
    const int rolls = 1000;
    
    for(int i = 0; i < rolls; i++) {
        [d6plus2 roll];
        STAssertTrue([d6plus2 value] <= 8, @"d6 roll was %d, expected <= 8", [d6plus2 value]);
        STAssertTrue([d6plus2 value] >= 3, @"d6 roll was %d, expected >= 3", [d6plus2 value]);
        total += [d6plus2 value];
    }
    
    STAssertEqualsWithAccuracy(total / rolls, [d6plus2 avg], 0.1, @"unexpected actual avg");
    STAssertEqualObjects(@"1d6+2", [d6plus2 description], @"wrong description?");
}

-(void)testBadDice
{
    // You can argue useful parsing for things like d3 and +7, if you want to implment it and remove them,
    // go ahead -- that'd be better.
    for (NSString *bad in [NSArray arrayWithObjects:@"BAD", @"d3", @"Xd2", @"2d4*8", @"2d3+", @"+7", nil]) {
        STAssertThrows([[Dice alloc] initWithString:bad], @"Expected '%@' to produce an error", bad);
    }
}

-(void)testThorsBigHammer
{
    Dice *dThorsBigHammer = [[Dice alloc] initWithString:@"3d12+4d6+8"];
    
    STAssertEquals(68, [dThorsBigHammer max], @"Higest roll of 3d12+4d6+8 should be 68");
    STAssertEquals(41.5, [dThorsBigHammer avg], @"Avg roll of 3d12+4d6+8 should be 45.5");
    double total = 0;
    const int rolls = 1000;
    
    for(int i = 0; i < rolls; i++) {
        [dThorsBigHammer roll];
        STAssertTrue([dThorsBigHammer value] <= 68, @"d6 roll was %d, expected <= 68", [dThorsBigHammer value]);
        STAssertTrue([dThorsBigHammer value] >= 15, @"d6 roll was %d, expected >= 15", [dThorsBigHammer value]);
        total += [dThorsBigHammer value];
    }
    
    STAssertEqualsWithAccuracy(total / rolls, [dThorsBigHammer avg], 0.1, @"unexpected actual avg");
    STAssertEqualObjects(@"3d12+4d6+8", [dThorsBigHammer description], @"wrong description?");
}

@end
