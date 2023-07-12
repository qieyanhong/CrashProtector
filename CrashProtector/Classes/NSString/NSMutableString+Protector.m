//
//  NSMutableString+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSMutableString+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSMutableString (Protector)

+ (void)registerProtection {
    Class cls = [[NSMutableString string] class]; // __NSCFString
    
    [cls swizzleMethod:@selector(substringFromIndex:)
            withMethod:@selector(cp_mutableSubstringFromIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(substringToIndex:)
            withMethod:@selector(cp_mutableSubstringToIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(substringWithRange:)
            withMethod:@selector(cp_mutableSubstringWithRange:)
                 error:nil];
    
    [cls swizzleMethod:@selector(appendString:)
            withMethod:@selector(cp_appendString:)
                 error:nil];
    [cls swizzleMethod:@selector(insertString:atIndex:)
            withMethod:@selector(cp_insertString:atIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(replaceCharactersInRange:withString:)
            withMethod:@selector(cp_replaceCharactersInRange:withString:)
                 error:nil];
}

+ (void)resignProtection {
    Class cls = [[NSMutableString string] class];
    
    [cls swizzleMethod:@selector(cp_mutableSubstringFromIndex:)
            withMethod:@selector(substringFromIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(cp_mutableSubstringToIndex:)
            withMethod:@selector(substringToIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(cp_mutableSubstringWithRange:)
            withMethod:@selector(substringWithRange:)
                 error:nil];
    
    [cls swizzleMethod:@selector(cp_appendString:)
            withMethod:@selector(appendString:)
                 error:nil];
    [cls swizzleMethod:@selector(cp_insertString:atIndex:)
            withMethod:@selector(insertString:atIndex:)
                 error:nil];
    [cls swizzleMethod:@selector(cp_replaceCharactersInRange:withString:)
            withMethod:@selector(replaceCharactersInRange:withString:)
                 error:nil];
}

#pragma mark - __NSCFString

- (NSString *)cp_mutableSubstringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString substringFromIndex:]: index %ld beyond bounds %ld, self = %@", from, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_mutableSubstringFromIndex:from];
}

- (NSString *)cp_mutableSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString substringToIndex:]: index %ld beyond bounds %ld, self = %@", to, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_mutableSubstringToIndex:to];
}

- (NSString *)cp_mutableSubstringWithRange:(NSRange)range {
    if (NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString substringWithRange:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_mutableSubstringWithRange:range];
}

#pragma mark - __NSCFString can not be nil

- (void)cp_appendString:(NSString *)aString {
    if (aString == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString appendString:]: attempt to append nil string, self = %@", self];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_appendString:aString];
}

- (void)cp_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (loc > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString insertString:atIndex:]: loc %ld beyond bounds %ld, self = %@", loc, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (aString == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString replaceCharactersInRange:withString:]: attempt to insert nil string at location %ld, self = %@", loc, self];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        aString = @"";
    }
    
    [self cp_insertString:aString atIndex:loc];
}

- (void)cp_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString replaceCharactersInRange:withString:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (aString == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFString replaceCharactersInRange:withString:]: attempt to replace string with nil at location %ld, self = %@", range.location, self];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        aString = @"";
    }
    
    [self cp_replaceCharactersInRange:range withString:aString];
}

@end
