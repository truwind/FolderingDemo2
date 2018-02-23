//
//  UIViewController+Nav.m
//  Timing
//
//  Created by bflysoft on 2018. 1. 17..
//  Copyright © 2018년 tk84. All rights reserved.
//

#import "UIViewController+Nav.h"
#import "AppDelegate.h"

@implementation UIViewController (Nav)

- (UINavigationController *)getNavigationController {
    if (self.navigationController != nil) {
        return self.navigationController;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}

- (UIViewController *)getNodeViewController:(UIViewController *)parentViewController
{
//    LogEx(@"getNodeViewController");
    if (parentViewController.presentedViewController != nil) {
        return [self getNodeViewController:parentViewController.presentedViewController];
    } else {
        return parentViewController;
    }
}
@end
