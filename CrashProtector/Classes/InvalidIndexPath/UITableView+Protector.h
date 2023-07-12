//
//  UITableView+Protector.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Protector)

+ (void)registerProtection;
+ (void)resignProtection;

@end

NS_ASSUME_NONNULL_END
