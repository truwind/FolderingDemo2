//
//  ViewController.m
//  FolderingDemo2
//
//  Created by bflysoft on 2018. 2. 19..
//  Copyright © 2018년 bflysoft. All rights reserved.
//

#import "ViewController.h"
#import "FolderingDemo2-Swift.h"
#import "ZoomPhotoViewController.h"
#import "UIViewController+Nav.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, PhotoCellProtocol> {
    CGFloat kCloseCellHeight;//: CGFloat = 179
    CGFloat kOpenCellHeight;//: CGFloat = 488
    NSInteger kRowsCount;// = 10
    NSMutableArray * cellHeights;//: [CGFloat] = []
    NSIndexPath * selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setup {
    kCloseCellHeight = 280 + 10; // 하단 여백을 추가한다.(하단 영역이 짤리지 않게 함) : format = storyboard에서 설정한 foregroundView의 높이 + 여백 공간
    kOpenCellHeight = 400 + 10; // 하단 여백을 추가한다.(하단 영역이 짤리지 않게 함) : format = storyboard에서 설정한 containerView의 높이 + 여백 공간
    kRowsCount = 10;
    
    cellHeights = [[NSMutableArray alloc] initWithObjects:@(kCloseCellHeight), @(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight),@(kCloseCellHeight), nil];
    
    self.tableView.estimatedRowHeight = kCloseCellHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorColor = [UIColor clearColor];
    UIImage *patternImage = [UIImage imageNamed:@"background"];
    UIColor *patternColor = [UIColor colorWithPatternImage:patternImage];
    self.tableView.backgroundColor = patternColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(16, 0, 0, 0);
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"zoomPhoto"])
//    {
//        ZoomPhotoViewController *vwZoomPhoto = (ZoomPhotoViewController *)segue.destinationViewController;
//        vwZoomPhoto.imageName = @"01";
//    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kRowsCount;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [cellHeights[indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCell * fCell = (PhotosCell*)cell;
    if([cellHeights[indexPath.row] floatValue] == kCloseCellHeight) {
        [fCell unfold:NO animated:NO completion:nil];
    } else {
        [fCell unfold:YES animated:NO completion:nil];
    }
    fCell.number = indexPath.row;
    fCell.imageName = [NSString stringWithFormat:@"%02ld", indexPath.row+1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoldingCell"];
    cell.subPhotoNumber = 10;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.isAnimating) return;
    double duration = 0;
    
    if(selectedIndexPath && selectedIndexPath != indexPath) {
        // close old opened cell
        PhotosCell * oldCell = [tableView cellForRowAtIndexPath:selectedIndexPath];
        
        [cellHeights setObject:[NSNumber numberWithFloat:kCloseCellHeight] atIndexedSubscript:selectedIndexPath.row];
        [oldCell unfold:NO animated:YES completion:nil];
        duration = 0.5;
        [UIView animateWithDuration:duration delay:0 options:0 animations:^{
            [tableView beginUpdates];
            [tableView endUpdates];
        } completion:nil];
    }
    
    CGFloat height = [cellHeights[indexPath.row] floatValue];
    BOOL cellIsCollapsed = height == kCloseCellHeight;
    if(cellIsCollapsed){
        [cellHeights setObject:[NSNumber numberWithFloat:kOpenCellHeight] atIndexedSubscript:indexPath.row];
        [cell unfold:YES animated:YES completion:nil];
        duration = 0.5;
    } else {
        [cellHeights setObject:[NSNumber numberWithFloat:kCloseCellHeight] atIndexedSubscript:indexPath.row];
        [cell unfold:NO animated:YES completion:nil];
        duration = 0.5;
    }
    [UIView animateWithDuration:duration delay:0 options:0 animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
    
    selectedIndexPath = indexPath;
}

#pragma mark - PhotoCellProtocol
- (void) selectedMainImageWithIndex:(NSInteger)index {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZoomPhotoViewController * viewCon = [storyboard instantiateViewControllerWithIdentifier:@"ZoomPhotoView"];
    viewCon.imageName = [NSString stringWithFormat:@"%02ld", index+1];
    [viewCon setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:[viewCon getNavigationController] animated:YES completion:nil];
}

@end
