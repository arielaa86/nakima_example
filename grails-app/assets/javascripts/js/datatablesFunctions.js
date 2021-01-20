
var myTable;
var baseURL = window.location.origin;


function activeDataTables(){

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


    activateDataTableRapport();


    $('table.dataTableNoImport').DataTable({

        destroy: true,
        pageLength: 100,
        info: true,
        fixedHeader: true,
        bSort: false,


        language: {

            search: '',
            searchPlaceholder: 'Rechercher...',
            zeroRecords: "Aucun résultat",
        },


        "dom": '<"top"B>rft<"bottom"><"clear">',


        buttons: [

        ],
        select: {
            //style: 'multi'
        }

    });




}




/* update datatables when screen changed*/

function updateDataTables() {
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $($.fn.dataTable.tables(true)).css('width', '100%');
        $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
    });
}
