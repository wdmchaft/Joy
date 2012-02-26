//
//  JoyAppDelegate.h
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoyAppDelegate : NSObject <UIApplicationDelegate> {
    NSInteger COVER_SLIDER_VALUE;   //used as whole var in cover setting page
    BOOL COVER_SOUND_FLAG;          //used as whole car in cover setting page
    NSInteger JOY_SOUND_FLAG;       //
    NSInteger JOY_PASSWORD_FLAG;    //      
    NSInteger RATE_TO_UNLOCK;       //
}
@property (nonatomic) NSInteger COVER_SLIDER_VALUE;
@property (nonatomic) BOOL COVER_SOUND_FLAG;
@property NSInteger JOY_SOUND_FLAG;
@property NSInteger JOY_PASSWORD_FLAG;
@property NSInteger RATE_TO_UNLOCK;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
