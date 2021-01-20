package mccorletagencement

class Encaissement {

    double montant
    Date date

    static belongsTo = [paiement: Paiement]

    static constraints = {
        montant min: 1.0D
    }


    static mapping = {
        id generator:'sequence', params:[sequence:'encaissement_id_seq']
        sort id: "asc"

    }


    def cestPaye(){

        def calendar = Calendar.getInstance()

        calendar.setTime(new Date())
        calendar.set(Calendar.HOUR_OF_DAY, 23)
        calendar.set(Calendar.MINUTE, 59)

        if (date.before(calendar.getTime())) {
            return true
        }

        return false
    }


}
