//
//  NSDictionary+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSDictionary+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSDictionary (Protector)

+ (void)registerProtection {
    Class cls = [[NSDictionary alloc] class]; // __NSPlaceholderDictionary

    [cls swizzleMethod:@selector(initWithObjects:forKeys:count:)
            withMethod:@selector(initSafelyWithObjects:forKeys:count:)
                 error:nil];
}

+ (void)resignProtection {
    Class cls = [[NSDictionary alloc] class];
    
    [cls swizzleMethod:@selector(initSafelyWithObjects:forKeys:count:)
            withMethod:@selector(initWithObjects:forKeys:count:)
                 error:nil];
}

- (instancetype)initSafelyWithObjects:(id _Nonnull const [])objects forKeys:(id<NSCopying> _Nonnull const [])keys count:(NSUInteger)cnt {
    id newKeys[cnt];
    id newObjects[cnt];
    
    NSUInteger newCnt = 0;
    NSMutableArray *nilKeys = nil;
    for (NSUInteger i = 0; i < cnt; ++i) {
        if (keys[i] != nil && objects[i] != nil) {
            newKeys[newCnt] = keys[i];
            newObjects[newCnt] = objects[i];
            newCnt++;
        } else if (keys[i] != nil && objects[i] == nil) {
            if (nilKeys == nil) {
                nilKeys = [NSMutableArray array];
            }
            [nilKeys addObject:keys[i]];
        }
    }
    
    if (newCnt != cnt && [CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"-[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object, nil keys = %@", nilKeys];
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    
    self = [self initSafelyWithObjects:newObjects forKeys:newKeys count:newCnt];
    return self;
}

@end
