//
//  CrashProtector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "CrashProtector.h"
#import "NSArray+Protector.h"
#import "NSMutableArray+Protector.h"
#import "NSDictionary+Protector.h"
#import "NSMutableDictionary+Protector.h"
#import "NSString+Protector.h"
#import "NSMutableString+Protector.h"
#import "NSAttributedString+Protector.h"
#import "NSMutableAttributedString+Protector.h"
#import "NSJSONSerialization+Protector.h"
#import "UITableView+Protector.h"
#import "UICollectionView+Protector.h"
#import "UIView+Protector.h"
#import "NSObject+Protector.h"

@interface CrashProtector ()

@property (nonatomic, assign) BOOL protectNSArray;
@property (nonatomic, assign) BOOL protectNSMutableArray;
@property (nonatomic, assign) BOOL protectNSDictionary;
@property (nonatomic, assign) BOOL protectNSMutableDictionary;
@property (nonatomic, assign) BOOL protectNSString;
@property (nonatomic, assign) BOOL protectNSMutableString;
@property (nonatomic, assign) BOOL protectNSAttributeString;
@property (nonatomic, assign) BOOL protectNSMutableAttributeString;
@property (nonatomic, assign) BOOL protectNSJSONSerialization;
@property (nonatomic, assign) BOOL protectUITableView;
@property (nonatomic, assign) BOOL protectUICollectionView;
@property (nonatomic, assign) BOOL protectUIView;
@property (nonatomic, assign) BOOL protectNSObjectSelector;

@end

@implementation CrashProtector

+ (void)registerProtection {
    // beyond bounds & insert nil
    [CrashProtector protector].protectNSArray = YES;
    [CrashProtector protector].protectNSMutableArray = YES;
    
    [CrashProtector protector].protectNSDictionary = YES;
    [CrashProtector protector].protectNSMutableDictionary = YES;
    
    [CrashProtector protector].protectNSString = YES;
    [CrashProtector protector].protectNSMutableString = YES;
    
    [CrashProtector protector].protectNSAttributeString = YES;
    [CrashProtector protector].protectNSMutableAttributeString = YES;
    
    [CrashProtector protector].protectNSJSONSerialization = YES;
    
    // invalid indexPath
    [CrashProtector protector].protectUITableView = YES;
    [CrashProtector protector].protectUICollectionView = YES;
    
    // NaN
    [CrashProtector protector].protectUIView = YES;
    
    // unrecognized selector
    [CrashProtector protector].protectNSObjectSelector = YES;
}

+ (void)resignProtection {
    // beyond bounds & insert nil
    [CrashProtector protector].protectNSArray = NO;
    [CrashProtector protector].protectNSMutableArray = NO;
    
    [CrashProtector protector].protectNSDictionary = NO;
    [CrashProtector protector].protectNSMutableDictionary = NO;
    
    [CrashProtector protector].protectNSString = NO;
    [CrashProtector protector].protectNSMutableString = NO;
    
    [CrashProtector protector].protectNSAttributeString = NO;
    [CrashProtector protector].protectNSMutableAttributeString = NO;
    
    [CrashProtector protector].protectNSJSONSerialization = NO;
    
    // invalid indexPath
    [CrashProtector protector].protectUITableView = NO;
    [CrashProtector protector].protectUICollectionView = NO;
    
    // NaN
    [CrashProtector protector].protectUIView = NO;
    
    // unrecognized selector
    [CrashProtector protector].protectNSObjectSelector = NO;
}

- (void)setProtectNSArray:(BOOL)protectNSArray {
    if (_protectNSArray == protectNSArray) {
        return;
    }
    
    _protectNSArray = protectNSArray;
    if (_protectNSArray) {
        [NSArray registerProtection];
    } else {
        [NSArray resignProtection];
    }
}

- (void)setProtectNSMutableArray:(BOOL)protectNSMutableArray {
    if (_protectNSMutableArray == protectNSMutableArray) {
        return;
    }
    
    _protectNSMutableArray = protectNSMutableArray;
    if (_protectNSMutableArray) {
        [NSMutableArray registerProtection];
    } else {
        [NSMutableArray resignProtection];
    }
}

- (void)setProtectNSDictionary:(BOOL)protectNSDictionary {
    if (_protectNSDictionary == protectNSDictionary) {
        return;
    }
    
    _protectNSDictionary = protectNSDictionary;
    if (_protectNSDictionary) {
        [NSDictionary registerProtection];
    } else {
        [NSDictionary resignProtection];
    }
}

- (void)setProtectNSMutableDictionary:(BOOL)protectNSMutableDictionary {
    if (_protectNSMutableDictionary == protectNSMutableDictionary) {
        return;
    }
    
    _protectNSMutableDictionary = protectNSMutableDictionary;
    if (_protectNSMutableDictionary) {
        [NSMutableDictionary registerProtection];
    } else {
        [NSMutableDictionary resignProtection];
    }
}

- (void)setProtectNSString:(BOOL)protectNSString {
    if (_protectNSString == protectNSString) {
        return;
    }
    
    _protectNSString = protectNSString;
    if (_protectNSString) {
        [NSString registerProtection];
    } else {
        [NSString resignProtection];
    }
}

- (void)setProtectNSMutableString:(BOOL)protectNSMutableString {
    if (_protectNSMutableString == protectNSMutableString) {
        return;
    }
    
    _protectNSMutableString = protectNSMutableString;
    if (_protectNSMutableString) {
        [NSMutableString registerProtection];
    } else {
        [NSMutableString resignProtection];
    }
}

- (void)setProtectNSAttributeString:(BOOL)protectNSAttributeString {
    if (_protectNSAttributeString == protectNSAttributeString) {
        return;
    }
    
    _protectNSAttributeString = protectNSAttributeString;
    if (_protectNSAttributeString) {
        [NSAttributedString registerProtection];
    } else {
        [NSAttributedString resignProtection];
    }
}

- (void)setProtectNSMutableAttributeString:(BOOL)protectNSMutableAttributeString {
    if (_protectNSMutableAttributeString == protectNSMutableAttributeString) {
        return;
    }
    
    _protectNSMutableAttributeString = protectNSMutableAttributeString;
    if (_protectNSMutableAttributeString) {
        [NSMutableAttributedString registerProtection];
    } else {
        [NSMutableAttributedString resignProtection];
    }
}

- (void)setProtectNSJSONSerialization:(BOOL)protectNSJSONSerialization {
    if (_protectNSJSONSerialization == protectNSJSONSerialization) {
        return;
    }
    
    _protectNSJSONSerialization = protectNSJSONSerialization;
    if (_protectNSJSONSerialization) {
        [NSJSONSerialization registerProtection];
    } else {
        [NSJSONSerialization resignProtection];
    }
}

- (void)setProtectUITableView:(BOOL)protectUITableView {
    if (_protectUITableView == protectUITableView) {
        return;
    }
    
    _protectUITableView = protectUITableView;
    if (_protectUITableView) {
        [UITableView registerProtection];
    } else {
        [UITableView resignProtection];
    }
}

- (void)setProtectUICollectionView:(BOOL)protectUICollectionView {
    if (_protectUICollectionView == protectUICollectionView) {
        return;
    }
    
    _protectUICollectionView = protectUICollectionView;
    if (_protectUICollectionView) {
        [UICollectionView registerProtection];
    } else {
        [UICollectionView resignProtection];
    }
}

- (void)setProtectUIView:(BOOL)protectUIView {
    if (_protectUIView == protectUIView) {
        return;
    }
    
    _protectUIView = protectUIView;
    if (_protectUIView) {
        [UIView registerProtection];
    } else {
        [UIView resignProtection];
    }
}

- (void)setProtectNSObjectSelector:(BOOL)protectNSObjectSelector {
    if (_protectNSObjectSelector == protectNSObjectSelector) {
        return;
    }
    
    _protectNSObjectSelector = protectNSObjectSelector;
    if (_protectNSObjectSelector) {
        [NSObject registerUnrecognizedSelectorProtection];
    } else {
        [NSObject resignUnrecognizedSelectorProtection];
    }
}

static CrashProtector *instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (instancetype)protector {
    return [[self alloc] init];
}

@end
