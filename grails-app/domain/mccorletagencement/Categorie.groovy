package mccorletagencement

class Categorie {

    String description
    String icon

    static hasMany = [facturesFournisseur: FactureFournisseur]

    static constraints = {
        description unique: true
        icon nullable: true

    }

    static mapping = {
        id generator:'sequence', params:[sequence:'categorie_id_seq']
    }




    def getTotalMois(Date date){

        def calendar =  Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.DAY_OF_MONTH, 1)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)

        def minDate = calendar.getTime()

        calendar.setTime(date)
        def max = calendar.getActualMaximum(Calendar.DATE)
        calendar.set(Calendar.DAY_OF_MONTH, max)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.add(Calendar.DATE, 1)



        def maxDate = calendar.getTime()

        double total = 0

        if(facturesFournisseur != null) {

            facturesFournisseur.stream()
                    .filter({ f -> f.date.after(minDate) && f.date.before(maxDate) })
                    .forEach({ f -> total += f.montant })

        }

        return total
    }


    @Override
    public String toString() {
        return description
    }
}
