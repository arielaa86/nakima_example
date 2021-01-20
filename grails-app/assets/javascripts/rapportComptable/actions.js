var baseURL = window.location.origin;



function addToReport(id){

    let date = document.querySelector("input[id=date]").value;
    let label = document.querySelector("label[id=label"+id+"]");

    const formData = new FormData();
    formData.append('id', id);
    formData.append('date', date);

    fetch(baseURL + "/utilisateur/addToReport", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        label.innerHTML = data;
    }).catch((error) => {
        alert('Error:' + error);
    });

}



function getRapport(){

    let date = document.querySelector("input[id=date]").value;
    let rapport = document.querySelector("div[id=rapport]");

    const formData = new FormData();
    formData.append('date', date);

    fetch(baseURL + "/utilisateur/rapportComptableAjax", {
        method: "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        rapport.innerHTML = data;
        activateDataTableRapport();

    }).catch((error) => {
        alert('Error:' + error);
    });


}



function showMessage(texte) {

    setTimeout(function () {
        showAlert(texte);
    }, 150);

}


const activateDataTableRapport = () =>{
    $('table.dataTableRapport').DataTable({

        destroy: true,
        pageLength: 1000,
        /*"order": [[ 2, "desc" ]],*/

        responsive: {
            details: {
                type: 'column',
                target: 0
            }
        },
        columnDefs: [{
            className: 'control',
            orderable: false,
            targets: 0
        }],
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


        "dom": '<"top"B>rft<"bottom"><"clear">',


        buttons: [

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
        select: {
            //style: 'multi'
        }

    });
}


