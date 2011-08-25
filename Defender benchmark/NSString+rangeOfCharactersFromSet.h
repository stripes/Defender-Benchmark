//
//  NSString+rangeOfCharactersFromSet.h
//  Defender benchmark
//
//  Created by J Osborne on 8/25/11.
//  Copyright 2011 Apple. All rights reserved.
//



@interface NSString (rangeOfCharactersFromSet)
-(NSRange)rangeOfCharactersFromSet:(NSCharacterSet *)aSet options:(NSStringCompareOptions)mask range:(NSRange)aRange;
@end
