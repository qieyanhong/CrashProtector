//
//  NSObject+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSObject+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"
#import <objc/runtime.h>

static NSString * const CPBackupObjectClassName = @"CPBackupObject";
static id CPBackupObject = nil;

static id CPBackupImplementation(id self, SEL _cmd) {
    return nil;
}

@implementation NSObject (Protector)

+ (void)registerUnrecognizedSelectorProtection {
    [self swizzleMethod:@selector(forwardingTargetForSelector:)
             withMethod:@selector(cp_forwardingTargetForSelector:)
                  error:nil];
    
    // for unrecognized class selector
    Class metaClass = objc_getMetaClass(object_getClassName(NSObject.class));
    [metaClass swizzleMethod:@selector(forwardingTargetForSelector:)
                  withMethod:@selector(meta_forwardingTargetForSelector:)
                       error:nil];
}

+ (void)resignUnrecognizedSelectorProtection {
    [self swizzleMethod:@selector(cp_forwardingTargetForSelector:)
             withMethod:@selector(forwardingTargetForSelector:)
                  error:nil];
    
    Class metaClass = objc_getMetaClass(object_getClassName(NSObject.class));
    [metaClass swizzleMethod:@selector(meta_forwardingTargetForSelector:)
                  withMethod:@selector(forwardingTargetForSelector:)
                       error:nil];
}

#pragma mark - unrecognized selector

- (id)cp_forwardingTargetForSelector:(SEL)aSelector {
    // If a valid signature is returned, it indicates that the message has been forwarded to another class for processing and does not need to be protected
    if ([self methodSignatureForSelector:aSelector] != nil) {
        return [self cp_forwardingTargetForSelector:aSelector];
    }

    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance: %@", NSStringFromClass(self.class), NSStringFromSelector(aSelector), self];
        NSException *exception = [NSException exceptionWithName:NSObjectInaccessibleException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }

    if ([self isKindOfClass:NSNumber.class] && [NSString instancesRespondToSelector:aSelector]) {
        return [NSString stringWithFormat:@"%@", self];
    }

    return [self backupObjectWithMethod:aSelector];
}

- (id)meta_forwardingTargetForSelector:(SEL)aSelector {
    if ([self methodSignatureForSelector:aSelector] != nil) {
        return [self meta_forwardingTargetForSelector:aSelector];
    }
    
    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"+[%@ %@]: unrecognized selector sent to class: %@", self, NSStringFromSelector(aSelector), self];
        NSException *exception = [NSException exceptionWithName:NSObjectInaccessibleException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    
    return [self backupObjectWithMethod:aSelector];
}

- (id)backupObjectWithMethod:(SEL)aSelector {
    Class cls = NSClassFromString(CPBackupObjectClassName);
    
    if (!cls) {
        cls = objc_allocateClassPair(NSObject.class, CPBackupObjectClassName.UTF8String, 0);
        objc_registerClassPair(cls);
    }
    
    class_addMethod(cls, aSelector, (IMP)CPBackupImplementation, "@@:");
    
    if (CPBackupObject == nil) {
        CPBackupObject = [[cls alloc] init];
    }
    
    return CPBackupObject;
}

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"[%@ setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key %@, value = %@", self.class, key, value];
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    if ([CPLogger enabled]) {
        NSString *reason = [NSString stringWithFormat:@"[%@ valueForUndefinedKey:]: this class is not key value coding-compliant for the key %@", self.class, key];
        NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
        [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
    }
    return nil;
}

@end
