//
//  ZoomPhotoViewController.m
//  FolderingDemo2
//
//  Created by bflysoft on 2018. 2. 21..
//  Copyright © 2018년 bflysoft. All rights reserved.
//

#import "ZoomPhotoViewController.h"

@interface ZoomPhotoViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * imageViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * imageViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * imageViewTrailingConstraint;
@end

@implementation ZoomPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    UIImage * image = [UIImage imageNamed:self.imageName];
    [self.imageView setImage:image];
    self.scrollView.contentSize = image.size;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self updateMinZoomScaleForSize:self.view.bounds.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Action
- (IBAction)onClickedClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private func
- (void) updateMinZoomScaleForSize:(CGSize)size {
    CGFloat widthScale = size.width / self.imageView.bounds.size.width;
    CGFloat heightScale = size.height / self.imageView.bounds.size.height;
    CGFloat minScale = MIN(widthScale, heightScale);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.zoomScale = minScale;

}

- (void) updateConstraintsForSize:(CGSize)size {
    
    CGFloat yOffset = MAX(0, (size.height - self.imageView.frame.size.height) / 2);
    self.imageViewTopConstraint.constant = yOffset;
    self.imageViewBottomConstraint.constant = yOffset;
    
    CGFloat xOffset = MAX(0, (size.width - self.imageView.frame.size.width) / 2);
    self.imageViewLeadingConstraint.constant = xOffset;
    self.imageViewTrailingConstraint.constant = xOffset;
    
    [self.view layoutIfNeeded];
}

#pragma mark - UIScrollViewDelegate
- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [scrollView layoutIfNeeded];
#if 1
    [self updateConstraintsForSize:[UIScreen mainScreen].bounds.size];
#else
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    UIImageView *imageView = scrollView.subviews.firstObject;
    
    for (NSLayoutConstraint *constraint in imageView.superview.constraints)
    {
        if (constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondAttribute == NSLayoutAttributeTop && constraint.firstItem == imageView && constraint.secondItem == imageView.superview)
        {
            constraint.constant = offsetY;
        }
        else if (constraint.firstAttribute == NSLayoutAttributeLeft && constraint.secondAttribute == NSLayoutAttributeLeft && constraint.firstItem == imageView && constraint.secondItem == imageView.superview)
        {
            constraint.constant = offsetX;
        }
    }
#endif
}
@end
