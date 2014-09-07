var assetslib = {

	getAllPhotos:function(successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getAllPhotos", []);
	},
	
	getPhotoMetadata:function(urlList, successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getPhotoMetadata", [urlList]);
	},

	getThumbnails:function(urlList, successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getThumbnails", [urlList]);
	},

	getFullScreenPhotos:function(urlList, successCallback, errorCallback) {
		cordova.exec(successCallback, errorCallback, "AssetsLib", "getFullScreenPhotos", [urlList]);
	},
}	

module.exports = assetslib;