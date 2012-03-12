//
//  SHKRenRen.m
//  ShareKit
//
//  Created by icyleaf on 11-11-15.
//  Copyright (c) 2011 icyleaf.com. All rights reserved.
//

#import "SHKRenRen.h"
#import "SHKRenRenForm.h"

@implementation SHKRenRen
@synthesize renren;


static SHKRenRen *sharedRenRen = nil;

+ (SHKRenRen *)sharedSHKRenren 
{
    if ( ! sharedRenRen) 
    {
        sharedRenRen = [[SHKRenRen alloc] init];
    }
    
    return sharedRenRen;
}

- (id)init
{
	if ((self = [super init]))
	{		
        self.renren = [Renren sharedRenren];
	}
    
	return self;
}


#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return @"人人网";
}

+ (BOOL)canShareURL
{
	return YES;
}

+ (BOOL)canShareText
{
	return YES;
}

+ (BOOL)canShareImage
{
	return YES;
}

#pragma mark -
#pragma mark Configuration : Dynamic Enable

- (BOOL)shouldAutoShare
{
	return NO;
}


#pragma mark -
#pragma mark Authentication

- (BOOL)isAuthorized
{	
	return [self.renren isSessionValid];
}

- (void)promptAuthorization
{
    NSArray *permissions = [NSArray arrayWithObjects:@"status_update", @"photo_upload", nil];
    [self.renren authorizationWithPermisson:permissions andDelegate:self];
}

+ (void)logout
{
    [[Renren sharedRenren] logout:[SHKRenRen sharedSHKRenren]];
}

#pragma mark -
#pragma mark UI Implementation

- (void)show
{
    if (item.shareType == SHKShareTypeURL)
	{
        [item setCustomValue:[item.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  forKey:@"status"];
		[self showRenRenForm];
	}
    else if (item.shareType == SHKShareTypeImage)
	{
		[self showRenRenPublishPhotoDialog];
	}
	
	else if (item.shareType == SHKShareTypeText)
	{
        [item setCustomValue:item.text forKey:@"status"];
		[self showRenRenForm];
	}
}

- (void)showRenRenForm
{
    SHKRenRenForm *rootView = [[SHKRenRenForm alloc] initWithNibName:nil bundle:nil];	
	rootView.delegate = self;
	
	// force view to load so we can set textView text
	[rootView view];
	
	rootView.textView.text = [item customValueForKey:@"status"];
	rootView.hasAttachment = item.image != nil;
	
	[self pushViewController:rootView animated:NO];
	
	[[SHK currentHelper] showViewController:self];	
}

- (void)showRenRenPublishPhotoDialog
{
    [self.renren publishPhotoSimplyWithImage:item.image  
                                     caption:item.title];
}

- (void)sendForm:(SHKRenRenForm *)form
{	
	[item setCustomValue:form.textView.text forKey:@"status"];
	[self tryToSend];
}


#pragma mark -
#pragma mark Share API Methods

- (BOOL)validate
{
	NSString *status = [item customValueForKey:@"status"];
	return status != nil && status.length > 0 && status.length <= 140;
}

- (BOOL)send
{	
	if ( ! [self validate])
		[self show];
	
	else
	{	
		if (item.shareType == SHKShareTypeImage) 
        {
			[self showRenRenPublishPhotoDialog];
		} 
        else 
        {
			NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
            [params setObject:@"status.set" forKey:@"method"];
            [params setObject:[item customValueForKey:@"status"] forKey:@"status"];
            [self.renren requestWithParams:params andDelegate:self];
		}
		
		// Notify delegate
		[self sendDidStart];	
		
		return YES;
	}
	
	return NO;
}

#pragma mark - RenrenDelegate methods


-(void)renrenDidLogin:(Renren *)renren
{
    [self show];
}

- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error
{
	[self sendDidFailWithError:error];
}

- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response
{
	NSDictionary* params = (NSDictionary *)response.rootObject;
    if (params != nil && [params objectForKey:@"result"] != nil && [[params objectForKey:@"result"] intValue] == 1) 
    {
        [self sendDidFinish];
	}
    else
    {  
        [self sendDidFailWithError:[SHK error:SHKLocalizedString([params objectForKey:@"error_msg"])]];
    }
}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error
{ 
    [self sendDidFailWithError:[SHK error:SHKLocalizedString([error localizedDescription])]];
}

@end
