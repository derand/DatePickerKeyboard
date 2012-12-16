//
//  AppDelegate.h
//  DatePickerKeyboard
//
//  Created by Andrey Derevyagin on 12/16/12.
//  Copyright (c) 2012 derand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>
{
	UIActionSheet *_pickerViewPopup;
	UIDatePicker *_pickerView;
	NSDate *_dt;
    UITextField *_tf;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDate *dt;

@end
