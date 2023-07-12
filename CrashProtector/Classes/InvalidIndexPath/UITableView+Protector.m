//
//  UITableView+Protector.m
//  CrashProtector
//
//  Created by qieyanhong on 2023/7/10.
//

#import "UITableView+Protector.h"
#import "NSObject+CPSwizzle.h"
#import "CPLogger.h"

@implementation UITableView (Protector)

+ (void)registerProtection {
    [self swizzleMethod:@selector(scrollToRowAtIndexPath:atScrollPosition:animated:)
             withMethod:@selector(cp_scrollToRowAtIndexPath:atScrollPosition:animated:)
                  error:nil];
}

+ (void)resignProtection {
    [self swizzleMethod:@selector(cp_scrollToRowAtIndexPath:atScrollPosition:animated:)
             withMethod:@selector(scrollToRowAtIndexPath:atScrollPosition:animated:)
                  error:nil];
}

- (void)cp_scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if (indexPath.section >= self.numberOfSections) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[UITableView scrollToItemAtIndexPath:atScrollPosition:animated:]: section (%ld) beyond bounds (%ld)", indexPath.section, self.numberOfSections];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    if (indexPath.row >= [self numberOfRowsInSection:indexPath.section]) {
        if ([CPLogger enabled]) {
            NSString *reason = [NSString stringWithFormat:@"-[UITableView scrollToItemAtIndexPath:atScrollPosition:animated:]: row (%ld) beyond bounds (%ld) for section (%ld)", indexPath.row, [self numberOfRowsInSection:indexPath.section], indexPath.section];
            NSException *exception = [NSException exceptionWithName:NSRangeException reason:reason userInfo:nil];
            [CPLogger reportException:exception callStackSymbols:[NSThread callStackSymbols]];
        }
        return;
    }
    
    [self cp_scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

@end
