//
//  NSAttributedString+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSAttributedString+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSAttributedString (Protector)

+ (void)registerProtection {
    Class cls = [[[NSAttributedString alloc] initWithString:@"0"] class]; // NSConcreteAttributedString
    
    [cls swizzleMethod:@selector(initWithString:)
            withMethod:@selector(initSafelyWithString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(initWithString:attributes:)
            withMethod:@selector(initSafelyWithString:attributes:)
                 error:nil];
}

+ (void)resignProtection {
    Class cls = [[[NSAttributedString alloc] initWithString:@"0"] class];
    
    [cls swizzleMethod:@selector(initSafelyWithString:)
            withMethod:@selector(initWithString:)
                 error:nil];
    
    [cls swizzleMethod:@selector(initSafelyWithString:attributes:)
            withMethod:@selector(initWithString:attributes:)
                 error:nil];
}

#pragma mark - NSConcreteAttributedString

- (instancetype)initSafelyWithString:(NSString *)str {
    if (str == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteAttributedString initWithString:]: attempt to init with nil string, self = %@", self.string];
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
            NSString *reason = [NSString stringWithFormat:@"-[NSConcreteAttributedString initWithString:attributes:]: attempt to init with nil string, self = %@", self.string];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        str = @"";
    }
    
    self = [self initSafelyWithString:str attributes:attrs];
    return self;
}

@end
