function download(text){
	console.log("in download(text)")

	var element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8' + encodeURIComponent(text));
	element.setAttribute('download', 'testfile.txt');

	element.style.display = 'none';
	document.body.appendChild(element);
	console.log("before element.click()")
	element.click()
	console.log("after element.click()")
	document.body.removeChild(element);
};
dlFile = function(){
	download("U have been hacked!\n")
	//window.location.replace('https://google.com/');
}