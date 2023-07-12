//
//  NSMutableDictionary+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSMutableDictionary+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSMutableDictionary (Protector)

+ (void)registerProtection {
    Class cls = [[NSMutableDictionary dictionary] class]; // __NSDictionaryM

    [cls swizzleMethod:@selector(setObject:forKey:)
            withMethod:@selector(cp_setObject:forKey:)
                 error:nil];
}

+ (void)resignProtection {
    Class cls = [[NSMutableDictionary dictionary] class];

    [cls swizzleMethod:@selector(cp_setObject:forKey:)
            withMethod:@selector(setObject:forKey:)
                 error:nil];
}

- (void)cp_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSDictionaryM setObject:forKey:]: attempt to use a nil key insert object: %@", anObject];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSDictionaryM setObject:forKey:]: attempt to insert nil object, key = %@", aKey];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_setObject:anObject forKey:aKey];
}

@end
