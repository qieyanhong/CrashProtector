//
//  CRASHPROTECTORViewController.m
//  CrashProtector
//
//  Created by qieyanhong on 07/10/2023.
//  Copyright (c) 2023 qieyanhong. All rights reserved.
//

#import "CRASHPROTECTORViewController.h"
#import <CrashProtector/CrashProtector.h>

@interface CRASHPROTECTORViewController ()

@end

@implementation CRASHPROTECTORViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *testTypes = @[@"NSArray",
                           @"NSDictionary",
                           @"NSString",
                           @"NSAttributeString",
                           @"UITableView/UICollectionView",
                           @"UIView",
                           @"NSJSONSerialization",
                           @"Unrecognized selector"];
    
    NSArray *selectors = @[@"testArray",
                           @"testDictionary",
                           @"testString",
                           @"testAttributeString",
                           @"testInvalidIndexPath",
                           @"testView",
                           @"testJSONSerialization",
                           @"testUnrecognizedSelector"];
    
    CGFloat buttonW = self.view.frame.size.width;
    CGFloat buttonH = 40;
    CGFloat spacing = 20;
    for (int i = 0; i < testTypes.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 120 + (buttonH + spacing)*i, buttonW, buttonH);
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:testTypes[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SEL selector = NSSelectorFromString(selectors[i]);
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    button1.titleLabel.font = [UIFont systemFontOfSize:20];
    [button1 setTitle:@"resignProtection" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(resignProtection) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
}

- (void)testArray {
    NSArray *array = [NSArray alloc];
    NSArray *array0 = [[NSArray alloc] init];
    NSArray *array1 = @[];
    NSArray *array2 = @[@"0"];
    NSArray *array3 = @[@"0", @"1"];

    NSLog(@"%@, %@, %@, %@, %@", array.class, array0.class, array1.class, array2.class, array3.class);

    NSMutableArray *arrayM0 = [[NSMutableArray alloc] init];
    NSMutableArray *arrayM1 = [@[] mutableCopy];
    NSMutableArray *arrayM2 = [@[@"0"] mutableCopy];
    NSMutableArray *arrayM3 = [@[@"0", @"1"] mutableCopy];

    NSLog(@"%@, %@, %@, %@", arrayM0.class, arrayM1.class, arrayM2.class, arrayM3.class);

    NSLog(@"%@, %@, %@, %@",
          [array0 objectAtIndex:10],
          [array1 objectAtIndex:10],
          [array2 objectAtIndex:10],
          [array3 objectAtIndex:10]);

    NSLog(@"%@, %@, %@, %@",
          arrayM0[10],
          arrayM1[10],
          arrayM2[10],
          arrayM3[10]);

    NSLog(@"%@, %@", array0.firstObject, array1.firstObject);
    NSLog(@"%@, %@", array0.lastObject, array1.lastObject);

    [arrayM0 insertObject:@"1" atIndex:10];
    [arrayM0 removeObjectAtIndex:10];
    [arrayM0 replaceObjectAtIndex:10 withObject:@"1"];

    [arrayM0 addObject:nil];
    [arrayM0 insertObject:nil atIndex:0];
    [arrayM0 replaceObjectAtIndex:0 withObject:nil];

    NSString *luid = nil;
    NSArray *arr = @[@"0", luid, @"2"];

    NSLog(@"----------------%@", arr);
}

- (void)testDictionary {
    NSDictionary *dict0 = [NSDictionary alloc];
    NSDictionary *dict1 = @{};
    NSDictionary *dict2 = @{@"0":@"0"};
    NSDictionary *dict3 = @{@"0":@"0", @"1":@"1"};
    
    NSLog(@"%@, %@, %@, %@", dict0.class, dict1.class, dict2.class, dict3.class);
    
    NSMutableDictionary *dictM0 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictM1 = [@{} mutableCopy];
    NSMutableDictionary *dictM2 = [@{@"0":@"0"} mutableCopy];
    NSMutableDictionary *dictM3 = [@{@"0":@"0", @"1":@"1"} mutableCopy];
    
    NSLog(@"%@, %@, %@, %@", dictM0.class, dictM1.class, dictM2.class, dictM3.class);
    
    NSString *luId = nil;
    NSString *aKey = nil;
    
    [dictM1 setObject:luId forKey:@"dictM1"];
    dictM1[@"dictM1"] = @"hehe";
    dictM1[@"dictM1"] = nil;
    
    NSDictionary *dict = @{@"0":@"0", @"luId":luId, @"2":@"2", aKey:@"3"};
    NSLog(@"%@", dict);
}

- (void)testString {
    NSString *str0 = @"123";
    NSString *str1 = [NSString stringWithFormat:@"123"];
    NSMutableString *str2 = [@"123" mutableCopy];
    NSMutableString *str3 = [NSMutableString stringWithString:@"123"];
    
    NSLog(@"%@, %@, %@, %@", str0.class, str1.class, str2.class, str3.class);
    
    NSLog(@"%@", [str0 substringToIndex:10]);
    NSLog(@"%@", [str1 substringToIndex:10]);
    NSLog(@"%@", [str2 substringToIndex:10]);
    NSLog(@"%@", [str3 substringToIndex:10]);

    [str2 appendString:nil];
    
    NSLog(@"%@", [NSString stringWithCString:NULL encoding:NSUTF8StringEncoding]);
    NSLog(@"%@", [NSMutableString stringWithCString:NULL encoding:NSUTF8StringEncoding]);
}

- (void)testAttributeString {
    NSAttributedString *str0 = [[NSAttributedString alloc] initWithString:nil];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:nil attributes:nil];
    
    NSLog(@"%@, %@", str0.class, str1.class);
    
    [str1 appendAttributedString:nil];
    
    NSLog(@"%@", str1);
    
    [str1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"hehe"]];
    
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 0)];
}

- (void)testInvalidIndexPath {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
    [collectionView scrollToItemAtIndexPath:indexPath1 atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)testView {
    UIView *view = [[UIView alloc] init];
    
    CGFloat zero = 0;
    CGFloat width = 100.0 / zero;
    CGFloat heigth = 200.0 / zero;
    view.frame = CGRectMake(0, 0, width, heigth);
}

- (void)testJSONSerialization {
    NSData *data = nil;
    [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    id object = nil;
    [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
}

- (void)testUnrecognizedSelector {
    NSString *date = [NSDate date];
    NSString *string = [date uppercaseString];
    NSLog(@"class = %@, string = %@", date.class, string);
    
    NSString *number = @(100);
    NSLog(@"is 100: %d", [number isEqualToString:@"100"]);
    NSLog(@"subString = ", [number substringToIndex:1]);
}

- (void)resignProtection {
    [CrashProtector resignProtection];
}

@end
