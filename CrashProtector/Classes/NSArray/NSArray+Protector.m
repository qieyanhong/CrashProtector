//
//  NSArray+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSArray+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSArray (Protector)

+ (void)registerProtection {
    Class cls0 = NSClassFromString(@"__NSArray0"); // [@[] class]
    if (cls0 != nil) {
        [cls0 swizzleMethod:@selector(objectAtIndex:)
                 withMethod:@selector(cp_emptyObjectAtIndex:)
                      error:nil];
        [cls0 swizzleMethod:@selector(objectAtIndexedSubscript:)
                 withMethod:@selector(cp_emptyObjectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsS = NSClassFromString(@"__NSSingleObjectArrayI"); // [@[@"0"] class]
    if (clsS != nil) {
        [clsS swizzleMethod:@selector(objectAtIndex:)
                 withMethod:@selector(cp_singleObjectAtIndex:)
                      error:nil];
        [clsS swizzleMethod:@selector(objectAtIndexedSubscript:)
                 withMethod:@selector(cp_singleObjectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsI = NSClassFromString(@"__NSArrayI"); // [@[@"0", @"1"] class]
    if (clsI != nil) {
        [clsI swizzleMethod:@selector(objectAtIndex:)
                 withMethod:@selector(cp_arrayObjectAtIndex:)
                      error:nil];
        [clsI swizzleMethod:@selector(objectAtIndexedSubscript:)
                 withMethod:@selector(cp_arrayObjectAtIndexedSubscript:)
                      error:nil];
    }
    
    // after iOS 15，[@[@"0"] class]、[@[@"0", @"1"] class] -> NSConstantArray
    Class clsC = NSClassFromString(@"NSConstantArray");
    if (clsC != nil) {
        [clsC swizzleMethod:@selector(objectAtIndex:)
                 withMethod:@selector(cp_constantArrayObjectAtIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(objectAtIndexedSubscript:)
                 withMethod:@selector(cp_constantArrayObjectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsP = NSClassFromString(@"__NSPlaceholderArray"); // [[NSArray alloc] class]
    if (clsP != nil) {
        [clsP swizzleMethod:@selector(initWithObjects:count:)
                 withMethod:@selector(initSafelyWithObjects:count:)
                      error:nil];
    }
}

+ (void)resignProtection {
    Class cls0 = NSClassFromString(@"__NSArray0");
    if (cls0 != nil) {
        [cls0 swizzleMethod:@selector(cp_emptyObjectAtIndex:)
                 withMethod:@selector(objectAtIndex:)
                      error:nil];
        [cls0 swizzleMethod:@selector(cp_emptyObjectAtIndexedSubscript:)
                 withMethod:@selector(objectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsS = NSClassFromString(@"__NSSingleObjectArrayI");
    if (clsS != nil) {
        [clsS swizzleMethod:@selector(cp_singleObjectAtIndex:)
                 withMethod:@selector(objectAtIndex:)
                      error:nil];
        [clsS swizzleMethod:@selector(cp_singleObjectAtIndexedSubscript:)
                 withMethod:@selector(objectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsI = NSClassFromString(@"__NSArrayI");
    if (clsI != nil) {
        [clsI swizzleMethod:@selector(cp_arrayObjectAtIndex:)
                 withMethod:@selector(objectAtIndex:)
                      error:nil];
        [clsI swizzleMethod:@selector(cp_arrayObjectAtIndexedSubscript:)
                 withMethod:@selector(objectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsC = NSClassFromString(@"NSConstantArray");
    if (clsC != nil) {
        [clsC swizzleMethod:@selector(cp_constantArrayObjectAtIndex:)
                 withMethod:@selector(objectAtIndex:)
                      error:nil];
        [clsC swizzleMethod:@selector(cp_constantArrayObjectAtIndexedSubscript:)
                 withMethod:@selector(objectAtIndexedSubscript:)
                      error:nil];
    }
    
    Class clsP = NSClassFromString(@"__NSPlaceholderArray");
    if (clsP != nil) {
        [clsP swizzleMethod:@selector(initSafelyWithObjects:count:)
                 withMethod:@selector(initWithObjects:count:)
                      error:nil];
    }
}

#pragma mark - __NSArray0

- (id)cp_emptyObjectAtIndex:(NSUInteger)index {
    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"-[__NSArray0 objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    return nil;
}

- (id)cp_emptyObjectAtIndexedSubscript:(NSUInteger)index {
    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"-[__NSArray0 objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
        NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    return nil;
}


#pragma mark - __NSSingleObjectArrayI

- (id)cp_singleObjectAtIndex:(NSUInteger)index {
    if (index != 0) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSSingleObjectArrayI objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_singleObjectAtIndex:index];
}

- (id)cp_singleObjectAtIndexedSubscript:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSSingleObjectArrayI objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_singleObjectAtIndexedSubscript:index];
}

#pragma mark - __NSArrayI

- (id)cp_arrayObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayI objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_arrayObjectAtIndex:index];
}

- (id)cp_arrayObjectAtIndexedSubscript:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayI objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_arrayObjectAtIndexedSubscript:index];
}

#pragma mark - NSConstantArray

- (id)cp_constantArrayObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConstantArray objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_constantArrayObjectAtIndex:index];
}

- (id)cp_constantArrayObjectAtIndexedSubscript:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[NSConstantArray objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_constantArrayObjectAtIndexedSubscript:index];
}

#pragma mark - __NSPlaceholderArray

- (instancetype)initSafelyWithObjects:(id _Nonnull const [])objects count:(NSUInteger)cnt {
    id newObjects[cnt];
    NSUInteger newCnt = 0;
    
    for (NSUInteger i = 0; i < cnt; ++i) {
        if (objects[i] != nil) {
            newObjects[newCnt] = objects[i];
            newCnt++;
        }
    }
    
    self = [self initSafelyWithObjects:newObjects count:newCnt];
    
    if (newCnt != cnt && [CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"-[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[%ld]", cnt];
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    
    return self;
}

@end
