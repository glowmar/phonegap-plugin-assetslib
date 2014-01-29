phonegap-plugin-assetslib
=========================

phonegap plugin for accessing assets from iOS ALAssetsLibrary

phonegap-plugin-assetslib supports retrieval of all photo library thumbnails on iOS devices and displaying them in phonegap application. 

## Install
Use cordova command line tools to add phonegap-plugin-assetslib to your project

* In your project source directory execute: `cordova plugin add https://github.com/glowmar/phonegap-plugin-assetslib.git`

On the javascript side, the assetslib class is going to be avaiable in global scope `navigator.assetslib`

## Examples
*All examples assume you have successfully added phonegap-plugin-assetslib to your project*

To get all iOS library thumbnails data:

```javascript
getAllPhotoThumbnails:function() {
  if (navigator.assetslib) {
    navigator.assetslib.getAllPhotoThumbnails(this.onGetAllPhotoThumbnailsSuccess,
      this.onGetAllPhotoThumbnailsError);
  }
},
onGetAllPhotoThumbnailsSuccess:function(data){
  this.allThumbnails = data;
  alert("iOS onGetAllPhotosSuccess\n" + data.length);
  $.event.trigger("onGetAllPhotoThumbnailsSuccess");
},
onGetAllPhotoThumbnailsError:function(error){
  console.log("phonegap::onGetAllPhotoThumbnailsError > " + error);
}
```
