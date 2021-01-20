const baseURL = window.location.origin;
const devisId = document.getElementById('devisId');
const date = document.getElementById('date');
const divUpdate = document.getElementById('update');
const supplement = document.getElementById('supplement');

const sauvegarderSupplement = document.getElementById('sauvegarderSupplement');


const getDevisId = (id) => {
    devisId.value = id;

    const formData = new FormData();
    formData.append('devisId', id)

    fetch(baseURL + "/utilisateur/getSupplementDevis/", {
        "method": "POST",
        body: formData
    })
        .then(response => {
            return response.text();
        })
        .then(data => {
            supplement.value = data;
        })
        .catch((error) => {
            alert('Error:' + error);
        });
}


const changerSupplement = () => {

    const formData = new FormData();
    formData.append('devisId', devisId.value)
    formData.append('date', date.value)
    formData.append('supplement', supplement.value)

    fetch(baseURL + "/utilisateur/changerSupplementPoseur/", {
        "method": "POST",
        body: formData
    })
        .then(response => {
            return response.text();
        })
        .then(data => {
            $('#poseSupplementModal').modal('hide');
            divUpdate.innerHTML = data;
        })
        .catch((error) => {
            alert('Error:' + error);
        });
}

supplement.addEventListener('keyup', (e)=>{

    if( isNaN(supplement.value)) {
        sauvegarderSupplement.disabled = true;
    }else {

        let supplementValue = supplement.value * 1;

        if (supplementValue < 0 ) {
            sauvegarderSupplement.disabled = true;
        }else{
            sauvegarderSupplement.disabled = false;
        }

    }


})

sauvegarderSupplement.addEventListener('click',(e)=>{
    changerSupplement();
})