package mccorletagencement

import java.util.stream.Collector
import java.util.stream.Collectors

class FactureClient {

    Date date
    String accords

    Date dateValiditeAvoir
    boolean avoirUtilise

    boolean enlevement
    boolean livraisonMC

    boolean livraisonIncluse
    boolean horsLivraison
    boolean poseIncluse
    boolean horsPose

    byte[] signatureClient
    byte[] signatureDirecteur

    byte[] photoDecharge
    String documentType

    static belongsTo = [devis: Devis]
    static hasOne = [ordreProduction: OrdreProduction, signePar: Utilisateur]


    static hasMany = [paiements: Paiement, corrections: Correction]

    boolean closed = false
    boolean commission = false
    boolean lancerProduction = false
    double annulationDirection = 0.0

    String garantieMeubles
    String garantieFournitures
    String garantieAppareils

    boolean selectionCompta = false

    static constraints = {
        date nullable: true
        signatureClient nullable: true
        accords nullable: true
        signatureDirecteur nullable: true
        garantieAppareils nullable: true
        garantieFournitures nullable: true
        garantieMeubles nullable: true
        ordreProduction nullable: true
        dateValiditeAvoir nullable: true
        photoDecharge nullable: true, maxSize: 25 * 1024 * 1024
        documentType nullable: true
        signePar nullable: true

    }


    static mapping = {
        id generator: 'sequence', params: [sequence: 'factureClient_id_seq']
    }


    double totalPayer() {

        double total = this.devis.montant


        return total
    }


    double regleCeJour() {

        double totalPaye = 0.0D

        for (paiement in paiements) {

            if (!paiement.supprime && paiement.encaisse) {
                if (paiement.multiple) {

                    def calendar = Calendar.getInstance()

                    calendar.setTime(new Date())
                    calendar.set(Calendar.HOUR_OF_DAY, 23)
                    calendar.set(Calendar.MINUTE, 59)

                    def encaissements = Encaissement.findAllByPaiementAndDateLessThanEquals(paiement, calendar.getTime())

                    for (encaissement in encaissements) {
                        totalPaye += encaissement.montant
                    }

                } else {
                    totalPaye += paiement.montant
                }
            }

        }

        return totalPaye
    }

    double regleCeJourODP() {

        double totalPaye = 0.0D

        for (paiement in paiements) {

            if (!paiement.supprime && paiement.encaisse) {
                totalPaye += paiement.montant
            }

        }

        return totalPaye
    }


    double regleAlaDate(Date dateMin, Date dateMax) {

        double totalPaye = 0.0D

        def paiementsListe = paiements.stream()
                .filter { paiement -> paiement.date.after(dateMin) && paiement.date.before(dateMax) && !paiement.supprime && paiement.encaisse }
                .collect(Collectors.toList())

        for (paiement in paiementsListe) {

            if (paiement.multiple) {

                def encaissements = Encaissement.findAllByPaiementAndDateLessThanEquals(paiement, dateMax)

                for (encaissement in encaissements) {
                    totalPaye += encaissement.montant
                }

            } else {
                totalPaye += paiement.montant
            }

        }

        return totalPaye
    }


    double regleAlaDate(Date dateMax) {

        double totalPaye = 0.0D

        def paiementsListe = paiements.stream()
                .filter { paiement -> paiement.date.before(dateMax) && !paiement.supprime && paiement.encaisse }
                .collect(Collectors.toList())

        for (paiement in paiementsListe) {

            if (paiement.multiple) {

                def encaissements = Encaissement.findAllByPaiementAndDateLessThanEquals(paiement, dateMax)

                for (encaissement in encaissements) {
                    totalPaye += encaissement.montant
                }

            } else {
                totalPaye += paiement.montant
            }

        }

        return totalPaye
    }


    boolean aDesPaiementMultiple() {

        def paiementsListe = paiements.stream()
                .filter { paiement -> paiement.multiple && paiement.encaissements.size() > 0 && !paiement.supprime }
                .collect(Collectors.toList())

        return paiementsListe.size() > 0
    }


    double restantDu() {
        return totalPayer() - regleCeJour()
    }

    double restantDuAvecGesteCommercial() {
        return totalPayer() - annulationDirection - regleCeJour()
    }


    double restantDuODP() {
        return totalPayer() - annulationDirection - regleCeJourODP()
    }


    boolean isClosedSameDay() {
        def etat = Etat.findByDevisAndDescriptionAndCommissione(this.devis, "Acquittee", true)

        if (etat != null) {
            return true
        }

        return false
    }

    boolean isClosed() {

        if (closed) {
            return true
        }

        if (restantDuAvecGesteCommercial() == 0) {
            return true
        }

        return restantDu() == 0 || restantDu() < 0
    }

    int getTotalBdcComplementaires() {
        return ProjetComplementaire.findAllByProjetPrincipal(this.devis.projet)
                .stream()
                .filter {
                    projet -> isValide(projet)
                }
                .count()
    }


    int getTotalComplements() {
        return ProjetComplementaire.findAllByProjetPrincipal(this.devis.projet).size()
    }

    int getNumComplement() {

        def liste = ProjetComplementaire.findAllByProjetPrincipal(this.devis.projet)

        def total = 0

        if (liste.size() > 0) {
            def str = liste.get(liste.size() - 1).idInsitu.split("-")[1].replace('C', '')
            return Integer.valueOf(str) + 1
        }

        return total + 1
    }

    List<ProjetComplementaire> getAllComplements() {

        return ProjetComplementaire.findAllByProjetPrincipal(this.devis.projet)
                .stream()
                .filter { projet -> isValide(projet) }
                .collect(Collectors.toList())
    }

    boolean isValide(Projet p) {

        if (p.devisClient != null) {
            if (p.devisClient.facture != null) {
                return true
            }
        }

        return false
    }


    boolean pretPourLancerProduction() {


        def calendar = Calendar.getInstance()
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)

        def today = calendar.getTime()

        def delai = devis.projet.delaiRealisation

        calendar.setTime(delai)
        calendar.add(Calendar.DATE, -36)

        def delaiMoisCinq = calendar.getTime()

        return today.after(delaiMoisCinq) && !this.devis.projet.instanceOf(ProjetComplementaire)

    }

    boolean allCorrectionsDone() {

        return corrections.stream()
                .filter({ correction -> correction.corrige == false })
                .count() == 0


    }


    boolean tousLesPaiementsDansMemeMois(Date minDate, Date maxDate) {

        if (this.isClosed() || isClosedSameDay()) {

            def listePaiement = paiements.stream()
                    .filter({ paiement -> paiement.date.after(minDate) && paiement.date.before(maxDate) })
                    .collect(Collectors.toList())

            return listePaiement.size() == paiements.size()

        }


        return false

    }


    boolean montrerTableau() {
        if (this.devis.projet.instanceOf(ProjetCuisine) || this.devis.projet.instanceOf(ProjetSalleBain)) {
            if (this.devis.projet.planTravail.equals("Quartz")) {
                return false
            }
        }

        if (this.horsLivraison && this.horsPose) {
            return false
        }

        if (this.livraisonIncluse && this.horsPose) {
            return false
        }

        return true

    }


    String montrerPlanTravail() {
        if (this.devis.projet.instanceOf(ProjetCuisine) || this.devis.projet.instanceOf(ProjetSalleBain)) {
            return "(" + this.devis.projet.planTravail + ")"
        }
        return ""

    }


    int totalPaiements() {

        def paiementListe = paiements.stream()
                .filter({
                    paiement -> paiement.supprime == false
                }).collect(Collectors.toList())

        return paiementListe.size()
    }


    def getPaiementsActives() {

        def paiementListe = paiements.stream()
                .filter({
                    paiement -> paiement.supprime == false
                }).collect(Collectors.toList())

        return paiementListe.sort { it.date }
    }


    def getDateAcquittee() {
        if (devis.etats.size() > 0) {
            def etat = devis.etats.sort({ it.id }).getAt(devis.etats.size() - 1)

            if (etat.description == "Acquittee") {
                return etat.date
            }
        }

        return new Date()
    }


    def getPoseMontant() {

        def montantPose = (this.devis.agencementHT - (this.devis.agencementHT * this.devis.remisePourcentage / 100)) * 10 / 100

        if (this.devis.ancien) {
            return montantPose
        }

        return Math.ceil(montantPose)


    }


    def getLastUser() {

        if (this.devis.projet.transferts.size() > 0) {
            def transfert = this.devis.projet.transferts[0]

            return transfert.destination
        }

        return this.devis.projet.concepteur

    }


}
