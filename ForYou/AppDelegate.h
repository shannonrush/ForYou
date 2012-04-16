//
//  AppDelegate.h
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>

NSMutableString *senderID;

@class SettingsController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SettingsController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(NSString *)senderID;
+(void)setSenderID:(NSString *)newSenderID;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
