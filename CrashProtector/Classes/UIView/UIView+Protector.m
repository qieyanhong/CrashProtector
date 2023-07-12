//
//  UIView+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "UIView+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation UIView (Protector)

+ (void)registerProtection {
    [self swizzleMethod:@selector(setFrame:)
             withMethod:@selector(cp_setFrame:)
                  error:nil];
}

+ (void)resignProtection {
    [self swizzleMethod:@selector(cp_setFrame:)
             withMethod:@selector(setFrame:)
                  error:nil];
}

- (void)cp_setFrame:(CGRect)frame {
    if (isnan(frame.origin.x) || isnan(frame.origin.y) || isnan(frame.size.width) || isnan(frame.size.height)) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"UIView frame contains NaN: %@", NSStringFromCGRect(frame)];
            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        
        if (isnan(frame.origin.x)) {
            frame.origin.x = 0;
        }
        
        if (isnan(frame.origin.y)) {
            frame.origin.y = 0;
        }
        
        if (isnan(frame.size.width)) {
            frame.size.width = 0;
        }
        
        if (isnan(frame.size.height)) {
            frame.size.height = 0;
        }
    }
    
    [self cp_setFrame:frame];
}

@end
