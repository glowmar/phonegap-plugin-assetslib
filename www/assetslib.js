var assetslib = {
	getAllPhotoThumbnails:function(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getAllPhotoThumbnails", []);
	}
}	
module.exports = assetslib;