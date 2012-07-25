//
//  IRAQPPCSAssetCell.h
//  IRAQPhotoPickerController-Sample
//
//  Created by Evadne Wu on 7/24/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface IRAQPPCSAssetCell : UITableViewCell

@property (nonatomic, readwrite, weak) ALAsset *asset;
@property (nonatomic, readwrite, weak) IBOutlet UIImageView *assetImageView;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *assetInfoLabel;

@end
