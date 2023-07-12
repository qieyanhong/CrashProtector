//
//  NSMutableArray+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSMutableArray+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation NSMutableArray (Protector)

+ (void)registerProtection {
    Class cls = NSClassFromString(@"__NSArrayM"); // __NSArrayM
    if (cls) {
        [cls swizzleMethod:@selector(objectAtIndex:)
                withMethod:@selector(cp_mutableArrayObjectAtIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(objectAtIndexedSubscript:)
                withMethod:@selector(cp_mutableArrayObjectAtIndexedSubscript:)
                     error:nil];
        [cls swizzleMethod:@selector(addObject:)
                withMethod:@selector(cp_addObject:)
                     error:nil];
        [cls swizzleMethod:@selector(insertObject:atIndex:)
                withMethod:@selector(cp_insertObject:atIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(removeObjectAtIndex:)
                withMethod:@selector(cp_removeObjectAtIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(removeObjectsInRange:)
                withMethod:@selector(cp_removeObjectsInRange:)
                     error:nil];
        [cls swizzleMethod:@selector(setObject:atIndexedSubscript:)
                withMethod:@selector(cp_setObject:atIndexedSubscript:)
                     error:nil];
        [cls swizzleMethod:@selector(replaceObjectAtIndex:withObject:)
                withMethod:@selector(cp_replaceObjectAtIndex:withObject:)
                     error:nil];
    }
    
    Class clsF = NSClassFromString(@"__NSFrozenArrayM"); // __NSFrozenArrayM
    if (clsF) {
        [clsF swizzleMethod:@selector(objectAtIndex:)
                 withMethod:@selector(cp_frozenMutableArrayObjectAtIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(objectAtIndexedSubscript:)
                 withMethod:@selector(cp_frozenMutableArrayObjectAtIndexedSubscript:)
                      error:nil];
        [clsF swizzleMethod:@selector(addObject:)
                 withMethod:@selector(cp_frozenAddObject:)
                      error:nil];
        [clsF swizzleMethod:@selector(insertObject:atIndex:)
                 withMethod:@selector(cp_frozenInsertObject:atIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(removeObjectAtIndex:)
                 withMethod:@selector(cp_frozenRemoveObjectAtIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(removeObjectsInRange:)
                 withMethod:@selector(cp_frozenRemoveObjectsInRange:)
                      error:nil];
        [clsF swizzleMethod:@selector(setObject:atIndexedSubscript:)
                 withMethod:@selector(cp_frozenSetObject:atIndexedSubscript:)
                      error:nil];
        [clsF swizzleMethod:@selector(replaceObjectAtIndex:withObject:)
                 withMethod:@selector(cp_frozenReplaceObjectAtIndex:withObject:)
                      error:nil];
    }
}

+ (void)resignProtection {
    Class cls = NSClassFromString(@"__NSArrayM");
    if (cls) {
        [cls swizzleMethod:@selector(cp_mutableArrayObjectAtIndex:)
                withMethod:@selector(objectAtIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_mutableArrayObjectAtIndexedSubscript:)
                withMethod:@selector(objectAtIndexedSubscript:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_addObject:)
                withMethod:@selector(addObject:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_insertObject:atIndex:)
                withMethod:@selector(insertObject:atIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_removeObjectAtIndex:)
                withMethod:@selector(removeObjectAtIndex:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_removeObjectsInRange:)
                withMethod:@selector(removeObjectsInRange:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_setObject:atIndexedSubscript:)
                withMethod:@selector(setObject:atIndexedSubscript:)
                     error:nil];
        [cls swizzleMethod:@selector(cp_replaceObjectAtIndex:withObject:)
                withMethod:@selector(replaceObjectAtIndex:withObject:)
                     error:nil];
    }
    
    Class clsF = NSClassFromString(@"__NSFrozenArrayM"); // __NSFrozenArrayM
    if (clsF) {
        [clsF swizzleMethod:@selector(cp_frozenMutableArrayObjectAtIndex:)
                 withMethod:@selector(objectAtIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenMutableArrayObjectAtIndexedSubscript:)
                 withMethod:@selector(objectAtIndexedSubscript:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenAddObject:)
                 withMethod:@selector(addObject:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenInsertObject:atIndex:)
                 withMethod:@selector(insertObject:atIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenRemoveObjectAtIndex:)
                 withMethod:@selector(removeObjectAtIndex:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenRemoveObjectsInRange:)
                 withMethod:@selector(removeObjectsInRange:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenSetObject:atIndexedSubscript:)
                 withMethod:@selector(setObject:atIndexedSubscript:)
                      error:nil];
        [clsF swizzleMethod:@selector(cp_frozenReplaceObjectAtIndex:withObject:)
                 withMethod:@selector(replaceObjectAtIndex:withObject:)
                      error:nil];
    }
}

#pragma mark - __NSArrayM beyond bounds

- (id)cp_mutableArrayObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_mutableArrayObjectAtIndex:index];
}

- (id)cp_mutableArrayObjectAtIndexedSubscript:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_mutableArrayObjectAtIndexedSubscript:index];
}

#pragma mark - __NSArrayM can not be nil

- (void)cp_addObject:(id)anObject {
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM addObject:]: attempt to insert nil object at index %ld", self.count];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_addObject:anObject];
}

- (void)cp_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index < 0 || index > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM insertObject:atIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM insertObject:atIndex:]: attempt to insert nil object at index %ld", index];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_insertObject:anObject atIndex:index];
}

- (void)cp_removeObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM removeObjectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    [self cp_removeObjectAtIndex:index];
}

- (void)cp_removeObjectsInRange:(NSRange)range {
    if (NSMaxRange(range) > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM removeObjectsInRange:]: range %@ beyond bounds %ld", NSStringFromRange(range), self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    [self cp_removeObjectsInRange:range];
}

- (void)cp_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx < 0 || idx > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM setObject:atIndexedSubscript:]: index %ld beyond bounds %ld", idx, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (obj == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM setObject:atIndexedSubscript:]: attempt to insert nil object at index %ld", idx];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_setObject:obj atIndexedSubscript:idx];
}

- (void)cp_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM replaceObjectAtIndex:withObject:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM replaceObjectAtIndex:withObject:]: attempt to insert nil object at index %ld", index];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_replaceObjectAtIndex:index withObject:anObject];
}

#pragma mark - __NSFrozenArrayM beyond bounds

- (id)cp_frozenMutableArrayObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM objectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_frozenMutableArrayObjectAtIndex:index];
}

- (id)cp_frozenMutableArrayObjectAtIndexedSubscript:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM objectAtIndexedSubscript:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    
    return [self cp_frozenMutableArrayObjectAtIndexedSubscript:index];
}

#pragma mark - __NSFrozenArrayM can not be nil

- (void)cp_frozenAddObject:(id)anObject {
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM addObject:]: attempt to insert nil object at index %ld", self.count];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_frozenAddObject:anObject];
}

- (void)cp_frozenInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index < 0 || index > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM insertObject:atIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM insertObject:atIndex:]: attempt to insert nil object at index %ld", index];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_frozenInsertObject:anObject atIndex:index];
}

- (void)cp_frozenRemoveObjectAtIndex:(NSUInteger)index {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM removeObjectAtIndex:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    [self cp_frozenRemoveObjectAtIndex:index];
}

- (void)cp_frozenRemoveObjectsInRange:(NSRange)range {
    if (NSMaxRange(range) > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM removeObjectsInRange:]: range %@ beyond bounds %ld", NSStringFromRange(range), self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    [self cp_frozenRemoveObjectsInRange:range];
}

- (void)cp_frozenSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx < 0 || idx > self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM setObject:atIndexedSubscript:]: index %ld beyond bounds %ld", idx, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (obj == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM setObject:atIndexedSubscript:]: attempt to insert nil object at index %ld", idx];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_frozenSetObject:obj atIndexedSubscript:idx];
}

- (void)cp_frozenReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < 0 || index >= self.count) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM replaceObjectAtIndex:withObject:]: index %ld beyond bounds %ld", index, self.count];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (anObject == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSArrayM replaceObjectAtIndex:withObject:]: attempt to insert nil object at index %ld", index];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_frozenReplaceObjectAtIndex:index withObject:anObject];
}

@end
