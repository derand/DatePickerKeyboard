//
//  AppDelegate.m
//  DatePickerKeyboard
//
//  Created by Andrey Derevyagin on 12/16/12.
//  Copyright (c) 2012 derand. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
	[_tf release];

	self.dt = nil;
	[_pickerView release];
	[_pickerViewPopup release];

    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	// Override point for customization after application launch.
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];

	self.window.backgroundColor = [UIColor whiteColor];
	

	_tf = [[UITextField alloc] initWithFrame:CGRectZero];
	_tf.frame = CGRectMake(50.0, 60.0, self.window.bounds.size.width-50.0*2.0, 28.0);
	_tf.borderStyle = UITextBorderStyleLine;
	_tf.autocorrectionType = UITextAutocorrectionTypeNo;
	_tf.keyboardType = UIKeyboardTypeDefault;
	_tf.delegate = self;
	_tf.textAlignment = UITextAlignmentCenter;
	[self.window addSubview:_tf];
	
	self.dt = [NSDate date];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
	
	[_pickerViewPopup release];
	_pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	
	[_pickerView release];
	_pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
	_pickerView.datePickerMode = UIDatePickerModeDate;
	_pickerView.hidden = NO;
	_pickerView.date = _dt;
	[_pickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
	
	UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	pickerToolbar.barStyle = UIBarStyleBlackOpaque;
	[pickerToolbar sizeToFit];
	
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
	[barItems addObject:flexSpace];
	[flexSpace release];
	
	UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
	[barItems addObject:doneBtn];
	[doneBtn release];
	
	UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
	[barItems addObject:cancelBtn];
	[cancelBtn release];
	
	[pickerToolbar setItems:barItems animated:YES];
	[barItems release];
	
	[_pickerViewPopup addSubview:pickerToolbar];
	[_pickerViewPopup addSubview:_pickerView];
    [_pickerViewPopup showInView:self.window];
    [_pickerViewPopup setBounds:CGRectMake(0.0, 0.0, 320.0, 464.0)];
	[pickerToolbar release];
}

- (void)dateChanged
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd.MM.yy"];
	_tf.text = [df stringFromDate:[_pickerView date]];
}


#pragma mark -

-(void)doneButtonPressed:(id)sender
{
	self.dt = [_pickerView date];
	
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
	[_pickerView removeTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)cancelButtonPressed:(id)sender
{
	self.dt = _dt;
	
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
	[_pickerView removeTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)setDt:(NSDate *)dt
{
	[dt retain];
	[_dt release];
	_dt = dt;
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd.MM.yy"];
	_tf.text = [df stringFromDate:_dt];
}


@end
