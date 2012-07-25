//
//  IRAQPPCSViewController.m
//  IRAQPhotoPickerController-Sample
//
//  Created by Evadne Wu on 7/11/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRAQPPCSViewController.h"
#import "IRAQPhotoPickerController.h"
#import "IRAQPPCSAssetCell.h"

@interface IRAQPPCSViewController ()
@property (nonatomic, readwrite, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, readwrite, strong) NSArray *assets;
@end

@implementation IRAQPPCSViewController
@synthesize assets = _assets;
@synthesize assetsLibrary = _assetsLibrary;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self)
		return nil;
	
	[self commonInit];
	
	return self;

}

- (void) awakeFromNib {

	[super awakeFromNib];
	
	[self commonInit];

}

- (void) commonInit {

	[self addObserver:self forKeyPath:@"assets" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

}

- (void) dealloc {

	[self removeObserver:self forKeyPath:@"assets"];

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	
}

- (ALAssetsLibrary *) assetsLibrary {

	if (!_assetsLibrary) {
	
		_assetsLibrary = [[ALAssetsLibrary alloc] init];
	
	}
	
	return _assetsLibrary;

}

- (NSArray *) assets {

	if (!_assets) {
	
		_assets = [NSArray array];
	
	}
	
	return _assets;

}

- (IBAction) handleAdd:(id)sender {
	
	__block IRAQPhotoPickerController *controller = [[IRAQPhotoPickerController alloc] initWithCompletion:^(NSArray *selectedAssets, NSError *error) {
	
		if (error) {
		
			if ([error.domain isEqualToString:ALAssetsLibraryErrorDomain]) {
				
				if ((error.code == ALAssetsLibraryAccessUserDeniedError) || (error.code == ALAssetsLibraryAccessUserDeniedError)) {
					
					NSLog(@"probably denied");

				}
				
			}
		
		} else {
		
			if (selectedAssets) {
			
				__weak IRAQPPCSViewController *wSelf = self;
			
				for (ALAsset *asset in selectedAssets) {
					
					NSArray *assetReps = [asset valueForProperty:ALAssetPropertyRepresentations];
					NSDictionary *assetURLs = [asset valueForProperty:ALAssetPropertyURLs];
					NSString *repUTI = [assetReps lastObject];
					NSURL *assetURL = repUTI ? [assetURLs objectForKey:repUTI] : nil;
					
					if (!assetURL)
						continue;
					
					ALAssetsLibrary * const wAssetsLibrary = self.assetsLibrary;
					
					[wAssetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
					
						if (wSelf.assetsLibrary != wAssetsLibrary)
							return;
						
						[[wSelf mutableArrayValueForKey:@"assets"] addObject:asset];
						
					} failureBlock:^(NSError *error) {
					
						NSLog(@"%@", error);
						
					}];
					
				}
			
			}
		
		}
		
		[controller dismissViewControllerAnimated:YES completion:nil];
		controller = nil;
		
	}];
	
	[self presentViewController:controller animated:YES completion:nil];
	
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [self.assets count];

}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	if ([keyPath isEqualToString:@"assets"] && object == self) {
	
		if ([self isViewLoaded]) {
		
			[self.tableView reloadData];
		
		}
	
	}

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
	IRAQPPCSAssetCell *cell = (IRAQPPCSAssetCell *)[tableView dequeueReusableCellWithIdentifier:@"photoCell"];
	NSCParameterAssert([cell isKindOfClass:[IRAQPPCSAssetCell class]]);
	
	cell.asset = asset;

	return cell;
	
}

@end
