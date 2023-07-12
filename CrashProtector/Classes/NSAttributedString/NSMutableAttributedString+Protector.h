//
//  NSMutableAttributedString+Protector.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (Protector)

+ (void)registerProtection;
+ (void)resignProtection;

@end

NS_ASSUME_NONNULL_END
