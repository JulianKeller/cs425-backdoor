function download(filename, text){
	console.log("in download(text)")

	let element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8' + encodeURIComponent(text));
	element.setAttribute('download', filename);

	element.style.display = 'none';
	document.body.appendChild(element);
	element.click()
	document.body.removeChild(element);
};
window.onload = function(){
	this.document.getElementById("btn").addEventListener("click",function(){
		let text = document.getElementById("text").value;
		let file = "test.txt";
		download(file,text);


	},false)
}