//
//  IRAQPPCSViewController.m
//  IRAQPhotoPickerController-Sample
//
//  Created by Evadne Wu on 7/11/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRAQPPCSViewController.h"
#import "IRAQPhotoPickerController.h"

@interface IRAQPPCSViewController ()

@end

@implementation IRAQPPCSViewController

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	
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
			
				NSLog(@"handle assets!");
			
			}
		
		}
		
		[controller dismissViewControllerAnimated:YES completion:nil];
		controller = nil;
		
	}];
	
	[self presentViewController:controller animated:YES completion:nil];
	
}

@end
