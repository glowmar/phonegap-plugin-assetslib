phonegap-plugin-assetslib
=========================

phonegap plugin for accessing assets from iOS ALAssetsLibrary

phonegap-plugin-assetslib supports retrieval of all photo library thumbnails on iOS devices and displaying them in phonegap application. 

## Install
Use cordova command line tools to add phonegap-plugin-assetslib to your project

* In your project source directory execute: `cordova plugin add https://github.com/glowmar/phonegap-plugin-assetslib.git`

On the javascript side, the assetslib class is going to be avaiable in global scope `navigator.assetslib`

## API

getAllPhotoMetadata
```javascript
///
// Gets all available photos matadata on a device
// @param   successCallback   callback function which will get the array with json objects of following format:
//                            {
//                              "url": url,
//                              "date": date,
//                              "gps_Latitude": <value if present in image metadata>,
//                              "gps_Longitude": <value if present in image metadata>,
//                              "gps_LatitudeRef": <value if present in image metadata>,
//                              "gps_LongitudeRef": <value if present in image metadata>,
//                              "exif_DateTimeOriginal": <value if present in image metadata>,
//                              "exif_DateTimeDigitized": <value if present in image metadata>,
//                              "iptc_Keywords": <value which is array of string if present in image metadata>
//                            }
// @param   errorCallback   callback function which will get the error
navigator.assetslib.getAllPhotoThumbnails(successCallback, errorCallback)
```

getThumbnails
```javascript
///
// Gets base64encoded thumbnails data for a given list of photo urls
// @param   urlList           Array of string urls, for example: [photometa[0].url]  or  [photometa[0].url,photometa[1].url]
// @param   successCallback   callback function which will get the array with json objects of following format:
//                            {
//                              "url": url,
//                              "base64encoded": base64encoded
//                            }
// @param   errorCallback   callback function which will get the error
navigator.assetslib.getThumbnails(urlList, successCallback, errorCallback)
```

getFullScreenPhotos
```javascript
///
// Gets device specific base64encoded full screen photo data for a given list of image urls
// @param   urlList           Array of string urls, for example: [photometa[0].url]  or  [photometa[0].url,photometa[1].url]
// @param   successCallback   callback function which will get the array with json objects of following format:
//                            {
//                              "url": url,
//                              "base64encoded": base64encoded
//                            }
// @param   errorCallback   callback function which will get the error
navigator.assetslib.getFullScreenPhotos(urlList, successCallback, errorCallback)
```

## Examples
*All examples assume you have successfully added phonegap-plugin-assetslib to your project*


To get an iOS photo library meta data use getAllPhotoMetadata:

```javascript
getAllPhotoMetadata:function() {
  if (navigator.assetslib) {
    navigator.assetslib.getAllPhotoMetadata(this.onGetAllPhotoMetadataSuccess, this.onGetAllPhotoMetadataError);
  }
},
onGetAllPhotoMetadataSuccess:function(data){
  this.photometa = data;
  alert("iOS onGetAllPhotoMetadataSuccess\n" + data.length);
},
onGetAllPhotoMetadataError:function(error){
  console.error("iOS onGetAllPhotoMetadataError > " + error);
}
```


To get one or more thumbnails for a list of asset url's:

```javascript
getThumbnails:function(urlList, successCallback, errorCallback){
  if (navigator.assetslib) {
    navigator.assetslib.getThumbnails(urlList, this.onGetThumbnailsSuccess, this.onGetThumbnailsError);
  }
},
onGetThumbnailsSuccess:function(data){
  this.thumbnails = data;
  alert("iOS onGetThumbnailsSuccess\n" + data.length);
},
onGetThumbnailsError:function(error){
  console.error("iOS onGetThumbnailsError > " + error);
}
```


To get device full screen size pictures for a list of url's:

```javascript
getFullScreenPhotos:function(urlList, successCallback, errorCallback){
  if (navigator.assetslib) {
    navigator.assetslib.getFullScreenPhotos(urlList, this.onGetFullScreenPhotosSuccess, this.onGetFullScreenPhotosError);
  }
},
onGetFullScreenPhotosSuccess:function(data){
  this.fullScreenPhotos = data;
  alert("iOS onGetFullScreenPhotosSuccess\n" + data.length);
},
onGetFullScreenPhotosError:function(error){
  console.error("iOS onGetFullScreenPhotosError > " + error);
}
```
