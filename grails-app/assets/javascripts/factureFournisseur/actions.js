var baseURL = window.location.origin;

function saveFacture() {

    var form = document.getElementById('facture-form');
    var errorsFacture = document.querySelector("div[id=errorsFacture]");
    var tableauFactures = document.querySelector("div[id=tableauFactures]");


    form.onsubmit = function () {

        var nom = document.querySelector("input[id=chercherFournisseur]").value;

        const formData = new FormData(form);

        fetch(baseURL + "/factureFournisseur/save", {
            method: "POST",
            body: formData
        }).then(response => {
            return response.text();
        }).then(data => {

            alert(data);

            if (data.includes("error")) {

                errorsFacture.innerHTML = data;

            } else {

                document.querySelector("span[id=parcourir]").innerHTML = "Parcourir ...";
                document.querySelector("input[id=file-1]").value = "";

                location.reload();

            }


        }).catch((error) => {
            alert('Error:' + error);
        });

        return false; // To avoid actual submission of the form
    }

}

function loadFacturesCategorie(id) {


    var tableauFactures = document.querySelector("div[id=tableauFactures]");

    const formData = new FormData();

    formData.append('id', id);

    fetch(baseURL + "/factureFournisseur/obtenir", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        tableauFactures.innerHTML = data;
        activeDataTables();


    }).catch((error) => {
        alert('Error:' + error);
    });

}

function filtrerFactures(id) {


    const formData = new FormData();

    formData.append('id', id);

    fetch(baseURL + "/factureFournisseur/obtenir", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        activeDataTables();

    }).catch((error) => {
        alert('Error:' + error);
    });

}




/*
function actualiserTableau(id) {

    $('#example').DataTable({

        pageLength: 20,
        destroy: true,
        processing: true,
        info: true,
        fixedHeader: true,
        language: {

            paginate: {
                previous: 'Préc.',
                next: 'Suiv.'
            },
            search: '',
            searchPlaceholder: 'Rechercher...',
            zeroRecords: "Aucun résultat",
        },

        "dom": '<"top"B>rft<"bottom"p><"clear">',

        buttons: [
            {
                extend: 'print',
                text: '<i class="fa fa-print" aria-hidden="true"></i> Imprimer',
                exportOptions: {
                    columns: ':visible:not(.notExport, .menu)'
                }
            },
            {
                extend: 'excel',
                text: '<i class="fa fa-file-excel-o" aria-hidden="true"></i> Excel',
                exportOptions: {
                    columns: ':visible:not(.notExport, .menu)'
                }

            },
            {
                extend: 'pdf',
                text: '<i class="fa fa-file-pdf-o" aria-hidden="true"></i> PDF',
                exportOptions: {
                    columns: ':visible:not(.notExport, .menu)'
                }

            }
        ],
        ajax: {
            "url": baseURL + "/factureFournisseur/obtenir?id=" + id
        },
        columns: [
            {'data': 'numero'},
            {'data': 'date'},
            {'data': 'fournisseur'},
            {'data': 'description'},
            {'data': 'montant'},
        ]
    });


}

 */