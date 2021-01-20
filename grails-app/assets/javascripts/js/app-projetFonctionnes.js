
    function hideElement(id) {
        document.getElementById(id).style.display = "none";
    }

    function hideElement2(element) {
        element.style.display = "none";
    }

    function showElement(id) {
        document.getElementById(id).style.display = "block";
    }


    function setupRadioGroups(){

        if(document.getElementById("devisRadioOui").checked) {
            showDevisOui();
        }else{
            hideDevisOui();
        }

        try {


            if (document.getElementById("coinRepasRadioOui").checked) {
                showCoinRepasOui();
            } else {
                hideCoinRepasOui();
            }
        }catch (error) {

        }

        try {

            if(document.getElementById("poigneesOui").checked) {
                showPoigneesModele();
            }else{

                hidePoigneesModele();
            }

        }catch (error) {

        }


        try {

            showQuantiteHabitation();

        }catch (error) {

        }



        try {

            showBudgetAutre();
            showFinancementAutre();



        }catch (error) {

        }


        try {

            showFacadeLaqueeCouleur();
            showFacadeBoisCouleur();

        }catch (error) {

        }


        try {


            var day =  document.getElementById("delaiRealisation_day");

            day.classList.add("custom-select");
            day.classList.add("form-control");

            var month =  document.getElementById("delaiRealisation_month");

            month.classList.add("custom-select");
            month.classList.add("form-control");

            var year =  document.getElementById("delaiRealisation_year");

            year.classList.add("custom-select");
            year.classList.add("form-control");

            document.getElementById("day").appendChild(day);
            document.getElementById("month").appendChild(month);
            document.getElementById("year").appendChild(year);



        }catch (error) {

        }


    }


    function showDetails(){
        if(document.getElementById("reference").value === "Autre"){
            showElement("referenceAutre");
        }else{
            hideElement("referenceAutre");
        }
    }



    function showBudgetAutre(){
        if(document.getElementById("budget").value === "Autre"){
            showElement("labelBudgetAutre");
            showElement("budgetAutre");
        }else{
            hideElement("labelBudgetAutre");
            hideElement("budgetAutre");
        }
    }



    function showFinancementAutre(){

        if(document.getElementById("financement").value === "Autre"){
            showElement("labelFinancementAutre");
            showElement("financementAutre");
        }else{
            hideElement("labelFinancementAutre");
            hideElement("financementAutre");
        }

    }



    /* ---- radiogroup Devis  ------*/

    function showDevisOui(){
          showElement("devisOui");
          showElement("labelDevisOui");
    }

    function hideDevisOui(){
        hideElement("devisOui");
        hideElement("labelDevisOui");
    }


    /* ---- radiogroup coinRepas  ------*/

    function showCoinRepasOui(){
        showElement("coinRepasOui");
        showElement("labelCoinRepasOui");
    }


    function hideCoinRepasOui(){
        hideElement("coinRepasOui");
        hideElement("labelCoinRepasOui");
    }


    /* ---- radiogroup Poignees  ------*/

    function showPoigneesModele(){
        showElement("poigneesModele");
        showElement("labelPoigneesModele");

        if(document.getElementById("poignees").value === "Autre"){
            showElement("labelPoigneesAutre");
            showElement("poigneesAutre");
        }
    }


    function hidePoigneesModele(){

        hideElement("poigneesModele");
        hideElement("labelPoigneesModele");
        hideElement("labelPoigneesAutre");
        hideElement("poigneesAutre");
    }



    function showPoigneesAutre(){

        if(document.getElementById("poignees").value === "Autre"){
            showElement("labelPoigneesAutre");
            showElement("poigneesAutre");
        }else{
            hideElement("labelPoigneesAutre");
            hideElement("poigneesAutre");
        }

    }

    function showQuantiteHabitation(){

        hideElement("labelQuantiteHabitation");
        hideElement("quantiteHabitation");

        try {

            hideElement("labelQuantitePieceEau");
            hideElement("quantitePieceEau");

        }catch (error) {

        }


        if(document.getElementById("typeHabitation").value === "Immeuble"){
            showElement("labelQuantiteHabitation");
            showElement("quantiteHabitation");
        }

        try {

            if(document.getElementById("typeHabitation").value === "Maison"){
                showElement("labelQuantitePieceEau");
                showElement("quantitePieceEau");
            }

        }catch (error) {

        }

    }




    function showFacadeLaqueeCouleur() {

        try {

            hideElement("labelFacadeLaqueeCouleur");
            hideElement("facadeLaqueeCouleur");

            if(document.getElementById("facadeLaquee").value != "Néant"){
                showElement("labelFacadeLaqueeCouleur");
                showElement("facadeLaqueeCouleur");
            }

        } catch (error) {

        }

    }



    function showFacadeBoisCouleur() {

        try {

            hideElement("labelFacadeBoisCouleur");
            hideElement("facadeBoisCouleur");

            if(document.getElementById("facadeBois").value != "Néant"){
                showElement("labelFacadeBoisCouleur");
                showElement("facadeBoisCouleur");
            }

        } catch (error) {

        }

    }



    function fitContent(id){
        var element = document.getElementById(id);
        element.style.height ="";
        var height = element.scrollHeight+100;
        element.style.height = height+"px";
    }












