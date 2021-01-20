package mccorletagencement.dataServices

import dtos.DevisDTO
import grails.gorm.transactions.Transactional
import mccorletagencement.Devis

@Transactional
class DevisDataService {

    def obtenirDevis(List<DevisDTO> devisReouvert, List<DevisDTO> devisNonValides, List<DevisDTO> devisAttente, List<DevisDTO> devisDecline, List<DevisDTO> devisBrouillons) {

        Devis.findAll().stream().filter({ devis ->
            devis.facture == null
        }).forEach({ devis ->

            DevisDTO devisDTO = new DevisDTO()
            devisDTO.setId(devis.id)
            devisDTO.setDate(devis.date)
            devisDTO.setIdInsitu(devis.projet.idInsitu)
            devisDTO.setClient(devis.projet.client.toString())
            devisDTO.setConcepteur(devis.getLastUser().toString())
            devisDTO.setTypeProjet(devis.projet.getType())
            devisDTO.setMontant(devis.montant)


            if (devis.reouvert) {
                devisReouvert.add(devisDTO)
            }

            if (devis.envoye && !devis.valide) {
                devisNonValides.add(devisDTO)
            }

            if (devis.valide && !devis.approuve && !devis.decline) {

                if( devis.expirationEnCours() ){
                    devisDTO.setExpirationEnCours(true)
                }

                if( devis.toujoursInteresse ){
                    devisDTO.setToujoursInteresse(true)
                }

                if( !devis.expire() && devis.expirationEnCours() && !devis.toujoursInteresse){
                    devisDTO.setRelance(true)
                }

                String telephone =  devis.projet.client.telephone != null ? "Téléphone: " + devis.projet.client.telephone : "Téléphone: " + devis.projet.client.telephoneFixe
                devisDTO.setTelephoneClient(telephone)

                devisAttente.add(devisDTO)
            }

            if (devis.valide && !devis.approuve && devis.decline) {

                if(devis.expireAuto){
                    devisDTO.setExpireAuto(true)
                }

                if( devis.questionnaire != null ){
                    devisDTO.setQuestionnaireId(devis.questionnaire.id)
                    devisDTO.setQuestionnaire(true)
                }

                if( devis.isQuestionnaireCompleted()){
                    devisDTO.setQuestionnaireCompleted(true)
                }


                devisDecline.add(devisDTO)
            }

            if (!devis.envoye && !devis.valide && !devis.reouvert) {
                devisBrouillons.add(devisDTO)
            }


        })

    }
}
