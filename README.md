phonegap-plugin-assetslib
=========================

phonegap plugin for accessing assets from iOS ALAssetsLibrary

phonegap-plugin-assetslib supports retrieval of all photo library thumbnails on iOS devices and displaying them in phonegap application. 

## Install
Use cordova command line tools to add phonegap-plugin-assetslib to your project

* In your project source directory execute: `cordova plugin add https://github.com/glowmar/phonegap-plugin-assetslib.git`

On the javascript side, the assetslib class is going to be avaiable in global scope `navigator.assetslib`

## API

getAllPhotoThumbnails
```javascript
///
// Gets all available photo thumbnails on a device
// @param   successCallback   callback function which will get the array with json objects of following format:
//                            {
//                              "url": url,
//                              "date": date,
//                              "base64encoded": base64encoded,
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

getFullScreenPhotos
```javascript
///
// Gets device specific full screen photos for a given list of image urls
// @param   urlList           Array of string urls, for example: [thumbs[0].url]  or  [thumbs[0].url,thumbs[1].url]
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

To get all iOS library thumbnails data use getAllPhotoThumbnails:

```javascript
getAllPhotoThumbnails:function() {
  if (navigator.assetslib) {
    navigator.assetslib.getAllPhotoThumbnails(this.onGetAllPhotoThumbnailsSuccess, this.onGetAllPhotoThumbnailsError);
  }
},
onGetAllPhotoThumbnailsSuccess:function(data){
  this.allThumbnails = data;
  alert("iOS onGetAllPhotosSuccess\n" + data.length);
},
onGetAllPhotoThumbnailsError:function(error){
  console.error("iOS onGetAllPhotoThumbnailsError > " + error);
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
