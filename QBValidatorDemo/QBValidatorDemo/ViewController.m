//
//  ViewController.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "ViewController.h"

#import "QBValidator.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UITextField *textField5;

@property (nonatomic, strong) NSMutableArray *states;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.states = [NSMutableArray arrayWithArray:@[@(NO), @(NO), @(NO), @(NO), @(NO)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self validate];
}


#pragma mark - Validating Fields

- (void)validate
{
    QBValidator *validator = [QBValidator validator];
    
    NSDictionary *errorMessages = nil;
    [validator validateValues:@{
                                @"field1": self.textField1.text,
                                @"field2": self.textField2.text,
                                @"field3": @([self.textField3.text integerValue]),
                                @"field4": @([self.textField4.text integerValue]),
                                @"field5": self.textField5.text
                                }
                        rules:@{
                                @"field1": @[QBVRequired],
                                @"field2": @[QBVEqualTo(self.textField1.text)],
                                @"field3": @[QBVInRange(1, 100)],
                                @"field4": @[QBVContainedIn(@[@(58), @(168)])],
                                @"field5": @[QBVEmail]
                                }
                errorMessages:&errorMessages];
    
    // Update states
    NSArray *fieldNames = @[@"field1", @"field2", @"field3", @"field4", @"field5"];
    
    [fieldNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fieldName = (NSString *)obj;
        
        NSArray *errors = errorMessages[fieldName];
        self.states[idx] = @((errors == nil || errors.count == 0));
    }];
    
    // Update table view
    [self.tableView reloadData];
    
    // Log messages
    NSLog(@"%@", errorMessages);
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSArray *textFields = @[self.textField1, self.textField2, self.textField3, self.textField4, self.textField5];
    [textFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = (UITextField *)obj;
        
        if ([textField isFirstResponder]) {
            [textField resignFirstResponder];
            *stop = YES;
        }
    }];
    
    return YES;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == tableView.numberOfSections - 1) {
        [self validate];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = (UITableViewHeaderFooterView *)view;
    
    BOOL state = [self.states[section] boolValue];
    footerView.textLabel.textColor = (state) ? [UIColor grayColor] : [UIColor redColor];
}

@end
