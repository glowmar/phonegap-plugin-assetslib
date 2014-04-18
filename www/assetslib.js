var assetslib = {
	
	getAllPhotoMetadata:function(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getAllPhotoMetadata", []);
	},

	getThumbnails:function(urlList, successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getThumbnails", [urlList]);
	}

	getFullScreenPhotos:function(urlList, successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getFullScreenPhotos", [urlList]);
	}
}	

module.exports = assetslib;