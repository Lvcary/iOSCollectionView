//
//  ViewController.m
//  iOSCollectionView
//
//  Created by 刘康蕤 on 2017/2/27.
//  Copyright © 2017年 刘康蕤. All rights reserved.
//

#import "ViewController.h"
#import "CustomFlowLayout.h"
#import "CustomCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,LKWaterFlowLayoutDelegate>

@property (nonatomic, strong)UICollectionView * collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Collection瀑布流";
    
    
    [self crateUI];
    
}


- (void)crateUI {

    CustomFlowLayout * layOut = [[CustomFlowLayout alloc] init];
    layOut.delegate = self;
    
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layOut];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark - CollectionViewDelegate 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 30;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.textLabelDetail.text = [NSString stringWithFormat:@"row = %ld",indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController * aclertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:@"啊哦"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定"
                                                      style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                          
                                                      }];
    [aclertController addAction:action];
    
    [self presentViewController:aclertController animated:YES completion:nil];
    
}



#pragma mark - CustomFlowLayotDelegate-
-(CGFloat)waterFlowLayout:(CustomFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
{
    return arc4random()%100+50;
}




//- (CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
//
//    return CGPointMake(10, 10);
//}

//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake(100, 100);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    
//    return CGSizeMake(100, 20);
//}




@end
