//
//  NSObject+CPSwizzle.h
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CPSwizzle)

+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
