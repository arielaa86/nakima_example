
var listeNotifications = document.querySelector("ul[id=listNotifications]");


var pusher = new Pusher('id_pusher', {
    cluster: 'us2'
});


var channel = pusher.subscribe('my-channel');
channel.bind('my-event', function (data) {

    var message = data.message;
    traiteMessage(message)

});



function traiteMessage(message){

    var userId = document.querySelector("input[name=userId]").value;

    if (message.includes("Task")) {
        $("#listeEvenement").load(window.location.href + " #listeEvenement");

        if(message.split(":")[1] !== userId && message.split(":")[2].includes(userId) ) {
            showIconAlert();
            showNotification("Notification!", "Vous avez un nouveau message");
        }
    }else {

        if (message === "signature") {


            $("#signaturesViewDirecteur").load(window.location.href + " #signaturesViewDirecteur");
            $("#signaturesView").load(window.location.href + " #signaturesView");
            $("#buttonImprimer").load(window.location.href + " #buttonImprimer");


        } else {

            updateDevisButtons();

            if (message.split(":")[1] !== userId && message.split(":")[2].includes(userId)) {

                playSound();
                showIconAlert();
                showNotification("Notification!", "Vous avez un nouveau message");
            }

        }
    }

}




function obtenirNotifications() {

    var baseURL = window.location.origin;

    fetch(baseURL+'/notification/obtenirNotifications', {
        "method": "GET"
    })
        .then(response => {
            return response.text()
        })
        .then(data => {

            listeNotifications.innerHTML = data;

        })
        .catch((error) => {
            alert('Error:' + error);
        });

}


function updateDevisButtons() {
    $("#actionsButtons").load(window.location.href + " #actionsButtons");
}


function hideIconAlert() {
    obtenirNotifications();
    localStorage.setItem('showAlert', 'no');
    document.getElementById("redAlert").style.setProperty('display', 'none', 'important');
}


function showIconAlert() {
    localStorage.setItem('showAlert', 'yes');
    document.getElementById("redAlert").style.setProperty('display', 'block', 'important');
}


$("#notificationIcon").click(function () {
    hideIconAlert();
});


function playSound() {

    var oggSource = '<source src="http://codeskulptor-demos.commondatastorage.googleapis.com/descent/gotitem.mp3" type="audio/mpeg">';

    document.getElementById("sound").innerHTML = '<audio autoplay = "autoplay" > ' + oggSource + ' < /audio>';
}


