// //
// //  BBBCardIO.m
// //  BBBCardIO
// //
// //  Created by Ollie Relph on 24/09/2015.
// //  Copyright © 2015 Oliver Relph. All rights reserved.
// //

#import "BBBCardIO.h"
#import "RCTEventDispatcher.h"
#import "CardIO.h"

@interface BBBCardIO () <CardIOPaymentViewControllerDelegate, RCTBridgeModule>

@property (copy) RCTResponseSenderBlock flowCompletedCallback;

@end

@implementation BBBCardIO

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getCreditCardInfo:(RCTResponseSenderBlock)flowCompletedCallback)

{

  CardIOPaymentViewController *vc = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];

  self.flowCompletedCallback = flowCompletedCallback;

  UIViewController *visibleVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
  do {
    if ([visibleVC isKindOfClass:[UINavigationController class]]) {
      visibleVC = [(UINavigationController *)visibleVC visibleViewController];
    } else if (visibleVC.presentedViewController) {
      visibleVC = visibleVC.presentedViewController;
    }
  } while (visibleVC.presentedViewController);

  [visibleVC presentViewController:vc animated:YES completion:^{
    // self.flowCompletedCallback(@[[NSNull null]]);
  }];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
  [paymentViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
    if (self.flowCompletedCallback) {

      self.flowCompletedCallback(@[[NSString stringWithFormat:@"%@,%02lu/%lu,%@.", info.cardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv]]);
    }
  }];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"User cancelled scan");
    [paymentViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
      self.flowCompletedCallback(@[[NSNull null]]);
    }];
}

@end

