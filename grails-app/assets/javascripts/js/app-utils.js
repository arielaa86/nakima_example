
// Select active tab in the menu
function showActiveTab(sessionController) {
    var a = document.getElementsByClassName('parent');
    // loop through all '<li class"nav-item parent">' elements
    for (i = 0; i < a.length; i++) {
        // Remove the class 'open' if it exists
        a[i].classList.remove('open');
    }

    var controller = sessionController;
    var elem = document.getElementById('home');
    //if the is no controller active go to home
    if (controller) {
        var elem = document.getElementById(controller);
    }
    elem.classList.add('open');
}




