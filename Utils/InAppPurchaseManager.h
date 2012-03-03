//
//  InAppPurchaseManager.h
//  QuickRussianBook
//
//  Created by mac on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
#define kInAppPurchaseProUpgradeProductId  @"com.pata.JoyOfSexCh.iap"


@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate,SKPaymentTransactionObserver>{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    BOOL isProUpgradePurchased;
}
@property (nonatomic, readonly) SKProduct *proUpgradeProduct;
@property (nonatomic, readonly) SKProductsRequest *productsRequest;

- (void)requestProUpgradeProductData;
- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;
@end
