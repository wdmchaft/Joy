//
//  JoyAppDelegate.h
//  Joy
//
//  Created by wordsworth on 12-2-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "Utils.h"

@interface JoyAppDelegate : NSObject <UIApplicationDelegate,MobClickDelegate> {
    NSInteger COVER_SLIDER_VALUE;   //used as whole var in cover setting page
    BOOL COVER_SOUND_FLAG;          //used as whole car in cover setting page
    NSInteger JOY_SOUND_FLAG;       //
    NSInteger JOY_PASSWORD_FLAG;    //      
    NSInteger RATE_TO_UNLOCK;       //
    NSString * DATABASE_NAME;   //check if the language environment is us or ch, decide which database should be use
    
    NSInteger SCROLLVIEW_HEIGHT;
    NSInteger SCROLLVIEW_HEIGHT_F;
    NSInteger IMAGEVIEW_HEIGHT;
    NSInteger TEXTVIEW_HEIGHT;
    NSInteger BUTTONVIEW_HEIGHT;
    
    NSString * SELF_AD_URL;
    NSString * ADMOB_ID_IPHONE;
    NSString * ADMOB_ID_IPAD;
}
@property (nonatomic) NSInteger COVER_SLIDER_VALUE;
@property (nonatomic) BOOL COVER_SOUND_FLAG;
@property NSInteger JOY_SOUND_FLAG;
@property NSInteger JOY_PASSWORD_FLAG;
@property NSInteger RATE_TO_UNLOCK;
@property NSString * DATABASE_NAME;
@property NSInteger SCROLLVIEW_HEIGHT;
@property NSInteger IMAGEVIEW_HEIGHT;
@property NSInteger TEXTVIEW_HEIGHT;
@property NSInteger BUTTONVIEW_HEIGHT; 
@property NSInteger SCROLLVIEW_HEIGHT_F;
@property (nonatomic, retain) NSString * SELF_AD_URL;
@property (nonatomic, retain) NSString * ADMOB_ID_IPHONE;
@property (nonatomic, retain) NSString * ADMOB_ID_IPAD;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
