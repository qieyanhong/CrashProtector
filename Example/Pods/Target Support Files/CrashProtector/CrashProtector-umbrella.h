#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CPLogger.h"
#import "CrashProtector.h"
#import "UICollectionView+Protector.h"
#import "UITableView+Protector.h"
#import "NSArray+Protector.h"
#import "NSAttributedString+Protector.h"
#import "NSMutableAttributedString+Protector.h"
#import "NSDictionary+Protector.h"
#import "NSMutableDictionary+Protector.h"
#import "NSJSONSerialization+Protector.h"
#import "NSMutableArray+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "NSObject+Protector.h"
#import "NSMutableString+Protector.h"
#import "NSString+Protector.h"
#import "UIView+Protector.h"

FOUNDATION_EXPORT double CrashProtectorVersionNumber;
FOUNDATION_EXPORT const unsigned char CrashProtectorVersionString[];

