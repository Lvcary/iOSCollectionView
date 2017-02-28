//
//  CustomFlowLayout.m
//  iOSCollectionView
//
//  Created by 刘康蕤 on 2017/2/27.
//  Copyright © 2017年 刘康蕤. All rights reserved.
//

#import "CustomFlowLayout.h"
/** 默认的列数*/
static const NSInteger LKDefaultColumeCount = 4;
/** 每一列之间的间距*/
static const NSInteger LKDefaultColumeMargin = 10;
/** 每一行之间的间距*/
static const CGFloat LKDefaultRowMargin = 10;
/** 边缘之间的间距*/
static const UIEdgeInsets LKDefaultEdgeInset = {10, 10, 10, 10};

@interface CustomFlowLayout()

/** 存放所有cell的布局属性*/
@property (strong, nonatomic) NSMutableArray *attrsArray;
/** 存放每一列的最大y值*/
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 每一行之间的间距*/
-(CGFloat)rowMargin;
/** 每一列之间的间距*/
-(CGFloat)columnMargin;
/** 列数*/
-(NSInteger)columnCount;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsets;

/** 内容的高度*/
@property (nonatomic, assign) CGFloat maxColumnHeight;

@end

@implementation CustomFlowLayout

-(CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        
        return [self.delegate rowMarginInWaterFlowLayout:self];
    }else
    {
        return LKDefaultRowMargin;
    }
}

-(CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    } else {
        return LKDefaultColumeMargin;
    }
}

-(NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        
        return [self.delegate columnCountInWaterFlowLayout:self];
    } else {
        return LKDefaultColumeCount;
    }
}

-(UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetInWaterFlowLayout:self];
    } else {
        return LKDefaultEdgeInset;
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
-(void)prepareLayout
{
    [super prepareLayout];
    
    //清除数据
    self.maxColumnHeight = 0;
    [self.columnHeights  removeAllObjects];
    
    for (NSInteger i = 0; i< self.columnCount; i++) {
        
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    //开始创建每一个cell
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i<count; i++) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/** 决定cell的排布*/
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}


/** 返回indexPath位置cell对应的布局属性*/
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView的宽度
    CGFloat collectionW = self.collectionView.frame.size.width;
    //设置布局属性的frame
    
    
    
    CGFloat w = (collectionW - self.edgeInsets.left - self.edgeInsets.right-(self.columnCount-1)*self.columnMargin)/self.columnCount;
    CGFloat h = [self.delegate waterFlowLayout:self heightForItemAtIndexPath:indexPath.item itemWidth:w];
    
    
    //找出最高的那一列
    NSInteger destColum = 0;
    CGFloat  minColumnHeight=[self.columnHeights[0] doubleValue];
    
    for (NSInteger i = 0; i<self.columnHeights.count; i++) {
        
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight>columnHeight) {
            
            minColumnHeight = columnHeight;
            destColum = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColum*(w + self.columnMargin);
    CGFloat y = minColumnHeight;
    
    if(y != self.edgeInsets.top )
    {
        if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
            y += [self.delegate rowMarginInWaterFlowLayout:self];
        } else {
            y += self.rowMargin;
        }
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    //更新最短那列的高度
    self.columnHeights[destColum] = @(CGRectGetMaxY(attrs.frame));
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColum] doubleValue];
    if (self.maxColumnHeight < columnHeight) {
        self.maxColumnHeight = columnHeight;
    }
    
    return attrs;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxColumnHeight + self.edgeInsets.bottom);
}


@end
