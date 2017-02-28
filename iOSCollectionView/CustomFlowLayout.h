//
//  CustomFlowLayout.h
//  iOSCollectionView
//
//  Created by 刘康蕤 on 2017/2/27.
//  Copyright © 2017年 刘康蕤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomFlowLayout;
@protocol LKWaterFlowLayoutDelegate <NSObject>

@required
-(CGFloat)waterFlowLayout:(CustomFlowLayout *)waterFlowLayout heightForItemAtIndexPath:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(CustomFlowLayout *)waterFlowLayout;
/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(CustomFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(CustomFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(CustomFlowLayout *)waterFlowLayout;

@end

@interface CustomFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,weak)id<LKWaterFlowLayoutDelegate>delegate;
@end
