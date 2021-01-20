let baseURL = window.location.origin;

function portefeuillePersonnel(id, nom, commerciaux) {

    clearSelection();

    const item = document.getElementById(id).firstElementChild
    item.style.boxShadow = '5px 10px 18px #888888';

    const portefeuille = document.getElementById('portefeuille')
    const commercialNom = document.getElementById('commercialNom')
    const selectCommercial = document.getElementById('commercialId')
    const commercialOrigineId = document.getElementById('commercialOrigineId')

    selectCommercial.innerHTML = '';

    const formData = new FormData();

    formData.append('id', id);

    fetch(baseURL + "/utilisateur/portefeuillePersonnel", {
        "method": "POST",
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {

        portefeuille.innerHTML = data
        commercialNom.textContent = nom
        commercialOrigineId.value = id

        activateTable()

        let str = commerciaux.replaceAll("id=", "\"id\":")
        str = str.replaceAll("nom=", "\"nom\":\"")
        str = str.replaceAll("}", "\"}")

        let json =  JSON.parse(str)


        for (let c of json){
            if(c.id != id) {
                let option = document.createElement('option')
                option.value = c.id
                option.textContent = c.nom
                selectCommercial.appendChild(option)
            }

        }




    }).catch((error) => {
        alert('Error:' + error);
    });

}



function setProjetId(id){
    const projetId = document.getElementById('projetId')
    projetId.value = id
}


function clearSelection(){

    const items = document.getElementsByClassName('item')

    for (let item of items){
        item.firstElementChild.style.boxShadow = '';

    }

}

function activateTable(){
    $('table.dataTable').DataTable({

        destroy: true,
        pageLength: 20,
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
        select: {
            //style: 'multi'
        }

    });
}



document.getElementById("transferer").addEventListener('click',()=>{

    const portefeuille = document.getElementById('portefeuille')
    const projetId = document.getElementById('projetId')
    const selectCommercial = document.getElementById('commercialId')
    const commercialOrigineId = document.getElementById('commercialOrigineId')

    const formData =  new FormData()

    formData.append('origine', commercialOrigineId.value)
    formData.append('destination', selectCommercial.value)
    formData.append('projet', projetId.value)



    fetch(baseURL + "/utilisateur/transfererDossier", {
        "method": "POST",
        body: formData
    }).then(response => {

        return response.text();

    }).then(data => {

        $('#transfertModal').modal('hide')
        showAlert('Le projet a bien été transféré');
        portefeuille.innerHTML = data
        activateTable()


    }).catch((error) => {
        alert('Error:' + error);
    })



})

