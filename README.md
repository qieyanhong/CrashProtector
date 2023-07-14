### Desciption:

* Swizzle commonly function of container, prevent crash
* Swizzle forwardInvocation, resolve unrecognized selector exception
* with the help of atos or Bugly, Can report logs to help developers analysis stack symbols

### Usage:

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [CrashProtector registerProtection];
    [CPLogger setReportBridge:^(NSException * _Nonnull exception, NSArray * _Nonnull callStackSymbols, NSString * _Nonnull slideAddress) {        
        // Upload logs to the server here
        
    }];
    
    return YES;
}
```


### Protected Functions(Developers can also add protection functions themselves):

* NSArray

```
- (ObjectType)objectAtIndex:(NSUInteger)index;
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)index; // array[index]
- (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt; // NSArray *array = @[nil];
```


* NSMutableArray

```
- (ObjectType)objectAtIndex:(NSUInteger)index;
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)index; // array[index]
- (void)addObject:(ObjectType)anObject;
- (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeObjectsInRange:(NSRange)range;
- (void)setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx; // mArray[idx] = nil
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;
```


* NSDictionary

```
- (instancetype)initWithObjects:(NSArray<ObjectType> *)objects forKeys:(NSArray<KeyType <NSCopying>> *)keys; // NSDictionary *dict = @{key:nil};
```


* NSMutableDictionary

```
- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
```


* NSString

```
+ (nullable instancetype)stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc;
- (NSString *)substringFromIndex:(NSUInteger)from;
- (NSString *)substringToIndex:(NSUInteger)to;
- (NSString *)substringWithRange:(NSRange)range;
```


* NSMutableString

```
- (NSString *)substringFromIndex:(NSUInteger)from;
- (NSString *)substringToIndex:(NSUInteger)to;
- (NSString *)substringWithRange:(NSRange)range;
- (void)appendString:(NSString *)aString;
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
```


* NSAttributedString

```
- (instancetype)initWithString:(NSString *)str;
- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
```


* NSMutableAttributedString

```
- (instancetype)initWithString:(NSString *)str;
- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
- (void)appendAttributedString:(NSAttributedString *)attrString;
- (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;
- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
```


* NSJSONSerialization

```
+ (nullable NSData *)dataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error;
+ (nullable id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;
```


* UITableView

```
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
```


* UICollectionView

```
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
```


* UIView

```
- (void)setFrame:(CGRect)frame; // NaN
```


* NSObject(unrecognized selector & KVC undefined key)

```
- (id)forwardingTargetForSelector:(SEL)aSelector;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;
```
