//
//  AssetsLib.h
//
//  Created by glowmar on 12/27/13.
//
//

#import <Cordova/CDVPlugin.h>

@interface AssetsLib : CDVPlugin

- (void)getAllPhotos:(CDVInvokedUrlCommand*)command;

@end
