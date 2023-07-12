//
//  UICollectionView+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "UICollectionView+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation UICollectionView (Protector)

+ (void)registerProtection {
    [self swizzleMethod:@selector(scrollToItemAtIndexPath:atScrollPosition:animated:)
             withMethod:@selector(cp_scrollToItemAtIndexPath:atScrollPosition:animated:)
                  error:nil];
}

+ (void)resignProtection {
    [self swizzleMethod:@selector(cp_scrollToItemAtIndexPath:atScrollPosition:animated:)
             withMethod:@selector(scrollToItemAtIndexPath:atScrollPosition:animated:)
                  error:nil];
}

- (void)cp_scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if (indexPath.section >= self.numberOfSections) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[UICollectionView scrollToItemAtIndexPath:atScrollPosition:animated:]: section (%ld) beyond bounds (%ld)", indexPath.section, self.numberOfSections];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (indexPath.item >= [self numberOfItemsInSection:indexPath.section]) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[UICollectionView scrollToItemAtIndexPath:atScrollPosition:animated:]: item (%ld) beyond bounds (%ld) for section (%ld)", indexPath.item, [self numberOfItemsInSection:indexPath.section], indexPath.section];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

@end
