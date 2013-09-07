//
//  NSAttributeDescription+ValueCoercion.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import "NSAttributeDescription+ValueCoercion.h"

@implementation NSAttributeDescription (ValueCoercion)

#ifdef TARGET_OS_IPHONE
- (UIView*)defaultKeyboardView
{
    int type = [self attributeType];
    
    if (NSDateAttributeType == type)
    {
        static UIDatePicker *datePicker;
        static dispatch_once_t once;
        
        dispatch_once (&once, ^{
            datePicker =  [[UIDatePicker alloc] init];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        });
        return datePicker;
    }
    
    return nil;
}

- (UIKeyboardType)defaultKeyboardType
{
    int type = UIKeyboardTypeDefault;
    
    switch (type)
    {
        case NSInteger16AttributeType:
        case NSInteger32AttributeType:
        case NSInteger64AttributeType:
            return UIKeyboardTypeNumberPad;
            
        case NSDecimalAttributeType:
        case NSDoubleAttributeType:
        case NSFloatAttributeType:
            return UIKeyboardTypeDecimalPad;
            
        case NSStringAttributeType:
        case NSDateAttributeType:
        case NSBooleanAttributeType:
        case NSBinaryDataAttributeType:
        case NSTransformableAttributeType:
        case NSObjectIDAttributeType:
        case NSUndefinedAttributeType:
        default:
            return UIKeyboardTypeDefault;
    }
}
#endif

- valueForStorageFrom:value
{
    int type = [self attributeType];
    id newValue;
    
    switch (type)
    {
        case NSInteger16AttributeType:
        case NSInteger32AttributeType:
        case NSInteger64AttributeType:
            newValue = @([value intValue]);
            break;
            
        case NSDecimalAttributeType:
            break;
            
        case NSDoubleAttributeType:
            newValue = @([value doubleValue]);
            break;
            
        case NSFloatAttributeType:
            newValue = @([value floatValue]);
            break;
            
        case NSStringAttributeType:
            newValue = [value description];
            break;
            
        case NSDateAttributeType:
            newValue = ([value isKindOfClass:[NSDate class]] ? value : nil);
            break;
            
        case NSBooleanAttributeType:
        case NSBinaryDataAttributeType:
        case NSTransformableAttributeType:
        case NSObjectIDAttributeType:
            
        case NSUndefinedAttributeType:
            newValue = value;
            break;
        default:
            break;
    }
    return newValue;
}

@end
