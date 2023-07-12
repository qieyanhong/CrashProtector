//
//  CPLogger.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPLogger : NSObject

+ (instancetype)logger;

/// 设置上报日志的桥（可借助atos解析堆栈）
+ (void)setReportBridge:(void(^)(NSException *exception, NSArray *callStackSymbols, NSString *slideAddress))bridge;

/// 上报日志
+ (void)reportException:(NSException *)exception callStackSymbols:(NSArray *)callStackSymbols;

+ (BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
