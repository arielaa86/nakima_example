package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import mccorletagencement.Commentaire
import mccorletagencement.Devis

import java.text.SimpleDateFormat

@Transactional
class CommentairesDataService {

    def getCommentaires(Devis devis, boolean isRelance){

        SimpleDateFormat formatDateComplete = new SimpleDateFormat("dd MMM yyyy HH:mm:ss",  Locale.FRANCE)
        SimpleDateFormat formatHour = new SimpleDateFormat("HH:mm",  Locale.FRANCE)
        SimpleDateFormat formatDate = new SimpleDateFormat("dd MMM yyyy", Locale.FRANCE)


        def jsonMap = Commentaire.findAllByDevisAndCommentaireRelance(devis, isRelance).stream()
                .collect {
                    commentaire ->
                        return [id: commentaire.id, dateComplete: formatDateComplete.format(commentaire.date),  date: formatDate.format(commentaire.date),heure: formatHour.format(commentaire.date), texte: commentaire.texte, createur: commentaire.createur.toString(), supprime: commentaire.supprime, commentaireRelance: commentaire.commentaireRelance, devis: commentaire.devis.id, auto: commentaire.commentaireAuto ]
                }

        return jsonMap

    }
}
