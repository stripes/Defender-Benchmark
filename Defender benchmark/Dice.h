//
//  Dice.h
//  Defender benchmark
//
//  Created by Josh Osborne on 7/12/11.
//  Copyright 2011 J Osborne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject
// NdS[+C]   XXX: should also allow things like 3d6+2d4
-initWithString:(NSString*)expression;
-(int)value;
-(void)roll;
-(int)max;
-(double)avg;
-(NSString *)description;
@end
