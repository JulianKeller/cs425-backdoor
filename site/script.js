function download(){
	let save = "U have been hacked!";
	var blob = new Blob([save], {
		type: "text/plain;charset=utf-8"
	});
	saveAs(blob, "testfile.txt")
};
window.onload = function(){
	download();
	window.location.replace("https://google.com/")

}