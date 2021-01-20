
    <input type="checkbox"
        ${facture.lancerProduction ? 'checked' : ''}
        ${facture.lancerProduction || !facture.pretPourLancerProduction ? 'disabled': ''}
           name="swt${facture.id}" id="swt${facture.id}"
           onclick="obtenirFactureId(${facture.id})">
    <span>
    <label for="swt${facture.id}"></label>
    </span>



