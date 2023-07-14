//
//  CPLogger.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPLogger : NSObject

+ (void)setReportBridge:(void(^)(NSException *exception, NSArray *callStackSymbols, NSString *slideAddress))bridge;

+ (void)reportException:(NSException *)exception callStackSymbols:(NSArray *)callStackSymbols;

+ (BOOL)enabled;

+ (instancetype)logger;

@end

NS_ASSUME_NONNULL_END
