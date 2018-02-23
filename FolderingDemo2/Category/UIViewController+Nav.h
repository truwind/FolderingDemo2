//
//  UIViewController+Nav.h
//  Timing
//
//  Created by bflysoft on 2018. 1. 17..
//  Copyright © 2018년 tk84. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nav)


- (UINavigationController *)getNavigationController;


- (UIViewController *)getNodeViewController:(UIViewController *)parentViewController;
@end
