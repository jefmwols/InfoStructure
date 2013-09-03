//
//  ISTableViewController.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol ISTableCellEditDelegate;


@protocol ISTableCellEditDelegate <NSObject>

@optional

- (BOOL)textField:(UITextField*)cell shouldReturnForIndexPath:(NSIndexPath*)indexPath
        withValue:(NSString *)value;

//Called to the delegate whenever the text in the textField is changed
- (void)tableCell:(UITextField*)inCell updateValue:inValue atIndexPath:(NSIndexPath *)inIndexPath;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end

typedef NS_OPTIONS(NSUInteger, IS_CONTROLER_STATE) {

    IS_STATE_VIEW       = 0x00,
    IS_STATE_CREATE     = 0x01,
    IS_STATE_EDIT       = 0x02,
    IS_STATE_LIST       = 0x03,
    
    IS_STATE_EDITABLE   = 1U << 2,
    IS_STATE_CREATABLE  = 1U << 3,
    IS_STATE_VIEWABLE   = 1U << 4,
    IS_STATE_DELETABLE  = 1U << 5
};

//==================================================================================
// ISTableViewController
//==================================================================================
@interface ISTableViewController : UITableViewController <ISTableCellEditDelegate>

@property (strong, nonatomic) id representedObject;

@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong) NSString *entityName;
@property (strong, nonatomic) NSEntityDescription *entityDescription;

@property(nonatomic,strong) NSArray *attributes;

@property(nonatomic) BOOL isDeletable;
@property(nonatomic) BOOL isEditable;
@property(nonatomic) BOOL isViewable;
@property(nonatomic) BOOL isCreatable;

- (id)initWithEntityName:(NSString*)entityName representedObject:value context:(NSManagedObjectContext*)moc;

- (NSAttributeDescription*)propertyForIndexPath:(NSIndexPath*)indexPath;
- (UITableViewCell*)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

- (void)tableCell:(UITableViewCell*)cell updateValue:inValue atIndexPath:(NSIndexPath *)inIndexPath;

@end


