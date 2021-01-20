package mccorletagencement

import java.util.stream.Collectors

class Client {

    String intitule
    String nom
    String prenom
    String adresse
    String codePostal
    String ville
    String telephone
    String telephoneFixe
    String email
    String secteurActivite
    String reference
    String referenceAutre

    static hasMany = [projets: Projet]


    static constraints = {

        intitule inList: ['Mme', 'Mr', 'Mme et Mr', 'Société']
        nom blank: false
        prenom nullable: false
        adresse blank: false
        codePostal blank: false, matches: "[0-9]+", minSize: 5, maxSize: 5
        ville blank: false
        telephone blank: false, nullable: false, matches: "[+]?[0-9 /]+"
        telephoneFixe blank: true, nullable: true, matches: "[+]?[0-9 /]+"
        email email: true, blank: true, nullable: true
        secteurActivite blank: true, nullable: true
        reference inList: ['Recommandation', 'Publicite', 'Foire', 'Salon', 'Autre']
        referenceAutre blank: true, nullable: true


    }

    static mapping = {
        id generator: 'sequence', params: [sequence: 'client_id_seq']
    }


    boolean hasFactures() {

        for (projet in Projet.findAllByClient(this)) {

            if (projet.devisClient != null) {
                if (projet.devisClient.facture != null) {
                    if (!projet.devisClient.facture.isClosed()) {
                        return true
                    }
                }
            }
        }

        return false
    }


    boolean hasDevis() {

        for (projet in Projet.findAllByClient(this)) {

            if (projet.devisClient != null) {
                if (!projet.devisClient.approuve) {
                    return true
                }
            }
        }

        return false

    }


    /*
    Utilisateur getConcepteur(){

        for (def projet in projets ){
            return projet.concepteur
        }

        return null

    }
    */


    @Override
    public String toString() {

        if(prenom == null ){
            return intitule+" "+nom
        }

        return intitule+" "+nom + " " + prenom
    }


    def obtenirAvoirs(){

       def projetsClient = projets.stream().filter({p -> p.client.id == this.id && p.devisClient != null && p instanceof ProjetComplementaire  }).collect(Collectors.toList())

        def avoirs = new ArrayList<Devis>()

        for(def projet in projetsClient){

            def devis = projet.devisClient
            if(devis.montant < 0 && devis.visible && devis.avoirExpire == false ){
                avoirs.add(devis)
            }

        }

        return avoirs

    }


    def obtenirAvoirsEdit(Long projetId){

        def projetsClient = projets.stream().filter({p -> p.client.id == this.id && p.devisClient != null && p instanceof ProjetComplementaire  }).collect(Collectors.toList())

        def avoirs = new ArrayList<Devis>()

        for(def projet in projetsClient){

            def devis = projet.devisClient
            if(devis.montant < 0 ){
                avoirs.add(devis)
            }

        }

        def projet = Projet.get(projetId)

        effacerAvoirUtilise(avoirs, projet)

        return avoirs

    }


    def effacerAvoirUtilise(List<Devis> avoirs, Projet projet){

      for (int i = avoirs.size()-1; i >=0; i--){

          def avoir = avoirs.get(i)

          def devis = Devis.findByAvoirUtilise(avoir.id)

          if(devis){

              if(projet.id  != devis.projet.id ){
                  avoirs.remove(avoir)
              }

          }

      }

    }
}
