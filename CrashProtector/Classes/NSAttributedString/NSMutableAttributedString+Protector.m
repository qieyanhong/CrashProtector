//
//  NSMutableAttributedString+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSMutableAttributedString+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSMutableAttributedString (Protector)

+ (void)registerProtection {
    Class cls = [[[NSMutableAttributedString alloc] initWithString:@""] class]; // NSConcreteMutableAttributedString

    [cls swizzleMethod:@selector(initWithString:)
            withMethod:@selector(initSafelyWithString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(initWithString:attributes:)
            withMethod:@selector(initSafelyWithString:attributes:)
                 error:nil];
    
    [cls swizzleMethod:@selector(appendAttributedString:)
            withMethod:@selector(cp_appendAttributedString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(addAttribute:value:range:)
            withMethod:@selector(cp_addAttribute:value:range:)
                 error:nil];
    
    [cls swizzleMethod:@selector(addAttributes:range:)
            withMethod:@selector(cp_addAttributes:range:)
                 error:nil];
}

+ (void)resignProtection {
    Class cls = [[[NSMutableAttributedString alloc] initWithString:@""] class];
    
    [cls swizzleMethod:@selector(initSafelyWithString:)
            withMethod:@selector(initWithString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(initSafelyWithString:attributes:)
            withMethod:@selector(initWithString:attributes:)
                 error:nil];
    
    [cls swizzleMethod:@selector(cp_appendAttributedString:)
            withMethod:@selector(appendAttributedString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(cp_addAttribute:value:range:)
            withMethod:@selector(addAttribute:value:range:)
                 error:nil];
    
    [cls swizzleMethod:@selector(cp_addAttributes:range:)
            withMethod:@selector(addAttributes:range:)
                 error:nil];
}

#pragma mark - NSConcreteMutableAttributedString

- (instancetype)initSafelyWithString:(NSString *)str {
    if (str == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteMutableAttributedString initWithString:]: attempt to init with nil string, self = %@", self.string];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        str = @"";
    }

    self = [self initSafelyWithString:str];
    return self;
}

- (instancetype)initSafelyWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    if (str == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteMutableAttributedString initWithString:attributes:]: attempt to init with nil string, self = %@", self.string];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        str = @"";
    }
    
    self = [self initSafelyWithString:str attributes:attrs];
    return self;
}

- (void)cp_appendAttributedString:(NSAttributedString *)attrString {
    if (attrString == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteMutableAttributedString appendAttributedString:]: attempt to insert with nil attrString, self = %@", self.string];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_appendAttributedString:attrString];
}

- (void)cp_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range {
    if (range.location != NSNotFound && NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteMutableAttributedString addAttribute:value:range:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self.string];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_addAttribute:name value:value range:range];
}

- (void)cp_addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range {
    if (range.location != NSNotFound && NSMaxRange(range) > self.length) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteMutableAttributedString addAttributes:range:]: range %@ beyond bounds %ld, self = %@", NSStringFromRange(range), self.length, self.string];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_addAttributes:attrs range:range];
}

@end
