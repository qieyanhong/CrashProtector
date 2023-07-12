//
//  CPLogger.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "CPLogger.h"
#import <mach-o/dyld.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@interface CPLogger ()

@property (nonatomic, copy) void (^bridge)(NSException *exception, NSArray *callStackSymbols, NSString *slideAddress);

@end

@implementation CPLogger

+ (void)setReportBridge:(void (^)(NSException * _Nonnull, NSArray * _Nonnull, NSString * _Nonnull))bridge {
    [CPLogger logger].bridge = bridge;
}

+ (void)reportException:(NSException *)exception callStackSymbols:(NSArray *)callStackSymbols {
    if ([CPLogger logger].bridge == nil) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [CPLogger logger].bridge(exception, callStackSymbols, [self projectSlideAddress]);
    });
}

/**
 Obtain the slide address of the main project.
 After Xcode 11, The entire project will become a whole, and dynamic libraries will no longer have their own slide addresses
 */
+ (NSString *)projectSlideAddress {
    static intptr_t slide = 0;

    if (slide > 0) {
        return [NSString stringWithFormat:@"0x%02lx", slide];
    }

    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        const struct mach_header *header = _dyld_get_image_header(i);
        if (header->filetype == MH_EXECUTE) {
            slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }

    return [NSString stringWithFormat:@"0x%02lx", slide];
}

+ (BOOL)enabled {
    return [CPLogger logger].bridge != nil;
}


static CPLogger *instance;

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (instancetype)logger {
    return [[CPLogger alloc] init];
}

@end
