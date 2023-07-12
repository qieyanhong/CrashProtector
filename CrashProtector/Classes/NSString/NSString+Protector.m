//
//  NSString+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSString+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"
#import <objc/runtime.h>

@implementation NSString (Protector)

+ (void)registerProtection {
    Class clsC = NSClassFromString(@"__NSCFConstantString"); // [@"0" class]
    if (clsC != nil) {
        [clsC swizzleMethod:@selector(substringFromIndex:)
                 withMethod:@selector(cp_constantSubstringFromIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(substringToIndex:)
                 withMethod:@selector(cp_constantSubstringToIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(substringWithRange:)
                 withMethod:@selector(cp_constantSubstringWithRange:)
                      error:nil];
    }
    
    Class clsT = NSClassFromString(@"NSTaggedPointerString"); // [[NSString stringWithFormat:@"0"] class]
    if (clsT != nil) {
        [clsT swizzleMethod:@selector(substringFromIndex:)
                 withMethod:@selector(cp_taggedPointerSubstringFromIndex:)
                      error:nil];
        [clsT swizzleMethod:@selector(substringToIndex:)
                 withMethod:@selector(cp_taggedPointerSubstringToIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(substringWithRange:)
                 withMethod:@selector(cp_taggedPointerSubstringWithRange:)
                      error:nil];
    }
    
    Class metaClass = objc_getMetaClass(object_getClassName(NSString.class)); // NSString
    [metaClass swizzleMethod:@selector(stringWithCString:encoding:)
                  withMethod:@selector(cp_stringWithCString:encoding:)
                       error:nil];
}

+ (void)resignProtection {
    Class clsC = NSClassFromString(@"__NSCFConstantString");
    if (clsC != nil) {
        [clsC swizzleMethod:@selector(cp_constantSubstringFromIndex:)
                 withMethod:@selector(substringFromIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(cp_constantSubstringToIndex:)
                 withMethod:@selector(substringToIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(cp_taggedPointerSubstringWithRange:)
                 withMethod:@selector(substringWithRange:)
                      error:nil];
    }
    
    Class clsT = NSClassFromString(@"NSTaggedPointerString");
    if (clsT != nil) {
        [clsT swizzleMethod:@selector(cp_taggedPointerSubstringFromIndex:)
                 withMethod:@selector(substringFromIndex:)
                      error:nil];
        [clsT swizzleMethod:@selector(cp_taggedPointerSubstringToIndex:)
                 withMethod:@selector(substringToIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(cp_taggedPointerSubstringWithRange:)
                 withMethod:@selector(substringWithRange:)
                      error:nil];
    }
    
    Class metaClass = objc_getMetaClass(object_getClassName(NSString.class));
    [metaClass swizzleMethod:@selector(cp_stringWithCString:encoding:)
                  withMethod:@selector(stringWithCString:encoding:)
                       error:nil];
}

#pragma mark - __NSCFConstantString

- (NSString *)cp_constantSubstringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFConstantString substringFromIndex:]: index %ld beyond bounds %ld, self = %@", from, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_constantSubstringFromIndex:from];
}

- (NSString *)cp_constantSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFConstantString substringToIndex:]: index %ld beyond bounds %ld, self = %@", to, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_constantSubstringToIndex:to];
}

- (NSString *)cp_constantSubstringWithRange:(NSRange)range {
    if (NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSCFConstantString substringWithRange:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_constantSubstringWithRange:range];
}

#pragma mark - NSTaggedPointerString

- (NSString *)cp_taggedPointerSubstringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSTaggedPointerString substringFromIndex:]: index %ld beyond bounds %ld, self = %@", from, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_taggedPointerSubstringFromIndex:from];
}

- (NSString *)cp_taggedPointerSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSTaggedPointerString substringToIndex:]: index %ld beyond bounds %ld, self = %@", to, self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_taggedPointerSubstringToIndex:to];
}

- (NSString *)cp_taggedPointerSubstringWithRange:(NSRange)range {
    if (NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSTaggedPointerString substringWithRange:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return self;
    }
    
    return [self cp_taggedPointerSubstringWithRange:range];
}

+ (instancetype)cp_stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc {
    if (cString == NULL) {
        if ([CPLogger enabled]) {
            NSString *reason = @"+[NSString stringWithCString:encoding:]: attempt to init with NULL cSting";
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return @"";
    }
    
    return [self cp_stringWithCString:cString encoding:enc];
}

@end
