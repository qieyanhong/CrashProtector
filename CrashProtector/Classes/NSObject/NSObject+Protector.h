//
//  NSObject+Protector.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <Foundation/Foundation.h>

@interface NSObject (Protector)

+ (void)registerUnrecognizedSelectorProtection;
+ (void)resignUnrecognizedSelectorProtection;

@end
