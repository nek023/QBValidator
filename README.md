# QBValidator
A library for validating values easily.


## Example
    QBValidator *validator = [QBValidator validator];
    
    NSDictionary *errorMessages = nil;
    BOOL isValid = [validator validateValues:@{
                                               @"key1": @"suzuya",
                                               @"key2": @"agano",
                                               @"key3": @(58),
                                               @"key4": @(168),
                                               @"key5": @"abc+123",
                                               @"key6": @"no.body..@example.com"
                                               }
                                       rules:@{
                                               @"key1": @[QBVRequired, QBVEqualTo(@"kumano")],
                                               @"key2": @[QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"])],
                                               @"key3": @[QBVNot(QBVEqualTo(@(58)))],
                                               @"key4": @[QBVInRange(1, 100)],
                                               @"key5": @[QBVMatch(@"^[a-zA-Z0-9]+$")],
                                               @"key6": @[QBVEmail]
                                               }
                               errorMessages:&errorMessages];
    
    // This example will fail.
    // Let's change the values to pass all tests :)
    if (isValid) {
        NSLog(@"OK!");
    } else {
        NSLog(@"errorMessages: %@", errorMessages);
    }


## Combine with forms
This library includes `UITextField+QBValidator` category that has the following methods.

* `- (void)setValidationRules:(NSArray *)rules`
* `- (NSArray *)validationRules`
* `- (BOOL)validate:(NSArray * __autoreleasing *)errorMessages`

So if you want to validate individual fields in your form, add rules by using `setValidationRules:` and validate by using `validateValue:name:rules:errorMessages:` of `QBValidator`.


## Create your own custom rules
You can create your own custom rules by subclassing `QBValidationRule`.  
The methods to be overridden are:

* Required
  * `- (BOOL)validateValue:(id)value`

* Optional
  * `- (NSString *)localizationTableName`
  * `- (NSString *)localizationKey`


## Localize
To localize error messages generated by `QBValidator`, you should create `QBValidator.strings` for different languages or create a subclass of `QBValidationRule` and override `localizationTableName` and `localizationKey`.


## Macros and functions
* `QBVRequired`
* `QBVEmail`
* `QBVURI`
* `QBVEqualTo(id value)`
* `QBVGreaterThan(id value)`
* `QBVGreaterThanOrEqualTo(id value)`
* `QBVLessThan(id value)`
* `QBVLessThanOrEqualTo(id value)`
* `QBVInRange(NSUInteger min, NSUInteger max)`
* `QBVInRange(NSUInteger min, NSUInteger max, BOOL inclusive)`
* `QBVContainedIn(NSArray *preferredValues)`
* `QBVNot(QBValidationRule *rule)`
* `QBVIf(QBValidationRule *rule, NSDictionary *conditionalRules)`
* `QBVMatch(NSString *pattern)`


## License
*QBValidator* is released under the **MIT License**, see *LICENSE.txt*.
