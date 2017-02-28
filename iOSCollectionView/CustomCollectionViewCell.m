//
//  CustomCollectionViewCell.m
//  iOSCollectionView
//
//  Created by 刘康蕤 on 2017/2/27.
//  Copyright © 2017年 刘康蕤. All rights reserved.
//

#import "CustomCollectionViewCell.h"



@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame) - 30)];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imageView];
        
        _textLabelDetail = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView.frame), CGRectGetWidth(imageView.frame), 30)];
        _textLabelDetail.textAlignment = NSTextAlignmentCenter;
        _textLabelDetail.font = [UIFont systemFontOfSize:12 weight:0.5];
        [self.contentView addSubview:_textLabelDetail];
        
    }
    return self;
}

@end
