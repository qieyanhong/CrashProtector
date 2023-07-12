//
//  NSJSONSerialization+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "NSJSONSerialization+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"
#import <objc/runtime.h>

@implementation NSJSONSerialization (Protector)

+ (void)registerProtection {
    Class metaCalss = objc_getMetaClass(object_getClassName(NSJSONSerialization.class));
    
    [metaCalss swizzleMethod:@selector(dataWithJSONObject:options:error:)
                  withMethod:@selector(cp_dataWithJSONObject:options:error:)
                       error:nil];
    
    [metaCalss swizzleMethod:@selector(JSONObjectWithData:options:error:)
                  withMethod:@selector(cp_JSONObjectWithData:options:error:)
                       error:nil];
}

+ (void)resignProtection {
    Class metaCalss = objc_getMetaClass(object_getClassName(NSJSONSerialization.class));
    [metaCalss swizzleMethod:@selector(cp_dataWithJSONObject:options:error:)
                  withMethod:@selector(dataWithJSONObject:options:error:)
                       error:nil];
    
    [metaCalss swizzleMethod:@selector(cp_JSONObjectWithData:options:error:)
                  withMethod:@selector(JSONObjectWithData:options:error:)
                       error:nil];
}

+ (NSData *)cp_dataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error {
    if (obj == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"+[NSJSONSerialization dataWithJSONObject:options:error:] obj parameter is nil"];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    return [self cp_dataWithJSONObject:obj options:opt error:error];
}

+ (id)cp_JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error {
    if (data == nil) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"+[NSJSONSerialization JSONObjectWithData:options:error:] data parameter is nil"];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return nil;
    }
    return [self cp_JSONObjectWithData:data options:opt error:error];
}

@end
