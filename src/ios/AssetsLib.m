//
//  AssetsLib.m
//
//  Created by glowmar on 12/27/13.
//
//

#import "AssetsLib.h"
#import "AssetsLibrary/ALAssetsLibrary.h"
#import "AssetsLibrary/ALAssetsFilter.h"
#import "AssetsLibrary/ALAssetsGroup.h"
#import "AssetsLibrary/ALAsset.h"


@interface AssetsLib ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *assets;
@property int assetsCount;

@end


@implementation AssetsLib

- (void)getAllPhotoThumbnails:(CDVInvokedUrlCommand*)command
{
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (self.groups == nil) {
        _groups = [[NSMutableArray alloc] init];
    } else {
        [self.groups removeAllObjects];
    }
    if (!self.assets) {
        _assets = [[NSMutableArray alloc] init];
    } else {
        [self.assets removeAllObjects];
    }
    self.assetsCount = 0;
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
            if ([self.assets count] == self.assetsCount)
            {
                NSLog(@"Got all %d photos",self.assetsCount);
                [self getAllPhotosComplete:command with:nil];
            }
        }
    };
    
    // setup our failure view controller in case enumerateGroupsWithTypes fails
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        NSString* errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
                errorMessage = @"The user has declined access to it.";
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
        NSLog(@"Problem reading assets library %@",errorMessage);
        [self getAllPhotosComplete:command with:errorMessage];
    };
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        // NSLog(@"AssetsLib::getAllPhotos::listGroupBlock > %@ (%d)   type: %@    url: %@",[group valueForProperty:ALAssetsGroupPropertyName],[group numberOfAssets],[group valueForProperty:ALAssetsGroupPropertyType],[group valueForProperty:ALAssetsGroupPropertyURL]);
        if ([group numberOfAssets] > 0)
        {
            NSLog(@"Got asset group \"%@\" with %d photos",[group valueForProperty:ALAssetsGroupPropertyName],[group numberOfAssets]);
            [self.groups addObject:group];
            self.assetsCount += [group numberOfAssets];
        }
        else
        {
            NSLog(@"Got all %d asset groups with total %d assets",[self.groups count],self.assetsCount);
            for (group in self.groups)
            {   // Enumarate each asset group
                ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
                [group setAssetsFilter:onlyPhotosFilter];
                [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
            }
        }
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAll; // ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos | ALAssetsGroupPhotoStream;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
}

- (void)getAllPhotosComplete:(CDVInvokedUrlCommand*)command with:(NSString*)error
{
    CDVPluginResult* pluginResult = nil;
     
    if (error != nil && [error length] > 0)
    {   // Call error
        NSLog(@"Error occured for command.callbackId:%@, error:%@", command.callbackId, error);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
    }
    else
    {   // Call was successful
        NSMutableDictionary* photos = [NSMutableDictionary dictionaryWithDictionary:@{}];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
        
        for (int i=0; i<[self.assets count]; i++)
        {
            ALAsset* asset = self.assets[i];
            NSString* url = [[asset valueForProperty:ALAssetPropertyAssetURL] absoluteString];
            NSString* date = [dateFormatter stringFromDate:[asset valueForProperty:ALAssetPropertyDate]];
            //NSString* location = [asset valueForProperty:ALAssetPropertyLocation];
            
            CGImageRef thumbnailImageRef = [asset thumbnail];
            UIImage* thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
            NSString* base64encoded = [UIImagePNGRepresentation(thumbnail) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            NSDictionary* photo = @{
                                    @"url": url,
                                    @"date": date,
                                    // @"location": location // have to check if it is not nil
                                    @"base64encoded": base64encoded
                                  };
            //NSLog(@"%d: %@", i, photo[@"url"]);
            [photos setObject:photo forKey:photo[@"url"]];
        }
        NSArray* photoMsg = [photos allValues];
        NSLog(@"Sending to phonegap application message with %d photos",[photoMsg count]);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:photoMsg];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
