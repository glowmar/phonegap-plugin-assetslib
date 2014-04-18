//
//  AssetsLib.h
//
//  Created by glowmar on 12/27/13.
//
//

#import <Cordova/CDVPlugin.h>

@interface AssetsLib : CDVPlugin

- (void)getAllPhotoMetadata:(CDVInvokedUrlCommand*)command;
- (void)getThumbnails:(CDVInvokedUrlCommand*)command;
- (void)getFullScreenPhotos:(CDVInvokedUrlCommand*)command;

@end
