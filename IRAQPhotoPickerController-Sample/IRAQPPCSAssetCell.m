//
//  IRAQPPCSAssetCell.m
//  IRAQPhotoPickerController-Sample
//
//  Created by Evadne Wu on 7/24/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "IRAQPPCSAssetCell.h"

@implementation IRAQPPCSAssetCell
@synthesize asset = _asset;
@synthesize assetImageView = _assetImageView;
@synthesize assetInfoLabel = _assetInfoLabel;

- (void) setAsset:(ALAsset *)asset {

	if (_asset == asset)
		return;
	
	_asset = asset;
	
	self.assetImageView.image = [UIImage imageWithCGImage:[_asset thumbnail]];
	
	self.assetInfoLabel.text = [[_asset.defaultRepresentation url] absoluteString];
	
}

@end
