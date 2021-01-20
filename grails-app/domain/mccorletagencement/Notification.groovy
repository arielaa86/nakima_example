package mccorletagencement

import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.Period
import java.util.concurrent.TimeUnit

class Notification {

    String texte
    String typeNotification
    String controleur
    String action
    Date date
    Long idObjet
    String projetIdInsitu
    Long creator
    String tempsEcoule
    Long tache
    Long[] destinataires


    boolean ancienne = false

    static constraints = {
        typeNotification inList: ['devisAttente', 'devisValide', 'devisRefuse','devisExpiration','devisReouvert',
                                  'calendrier', 'tacheAnnule', 'verificationAtelier', 'pretLivraison', 'correctionsEffectuees',
                                  'nouvelOrdre', 'correctionsAfaire', 'poseComplete', 'commentaireProd', 'erreurVerfication']
        projetIdInsitu nullable: true
        tempsEcoule nullable: true
        tache nullable: true
        destinataires nullable: true
    }


    static mapping = {
        id generator:'sequence', params:[sequence:'notification_id_seq']
        sort date: "desc" // or "asc"
    }


    def obtenirTempsEcoule(){

        Date actuelle = new Date()

        long diff = actuelle.getTime() - date.getTime()

        String hoursText = String.format("%02d", TimeUnit.MILLISECONDS.toHours(diff));

        String minText =  String.format("%02d", TimeUnit.MILLISECONDS.toMinutes(diff) % TimeUnit.HOURS.toMinutes(1))

        String secondsText =  String.format("%02d",TimeUnit.MILLISECONDS.toSeconds(diff) % TimeUnit.MINUTES.toSeconds(1))


        int hours = Integer.valueOf(hoursText)
        int min = Integer.valueOf(minText)
        int sec = Integer.valueOf(secondsText)



        if(hours >= 24 ){
            int jours = hours / 24
            int rest = hours % 24

            if(jours == 1 && rest == 0){
                return "Il y a "+ jours +" jour"
            }

            if(jours > 1 && rest == 0){
                return "Il y a "+ jours +" jours"
            }

            if(jours > 1 && rest > 0){
                if(rest > 1)
                    return "Il y a "+ jours +" jours "+rest+" heure"
                else
                    return "Il y a "+ hours +" jours "+rest+" heures"
            }

            return "Il y a "+ hours +" heure"
        }

        if(hours == 1 && min == 0){
            return "Il y a "+ hours +" heure"
        }

        if(hours == 1 && min > 0){
            if(min > 1)
                return "Il y a "+ hours +" heure "+min+" minutes"
            else
                return "Il y a "+ hours +" heure "+min+" minute"
        }

        if(hours > 1 && min == 0){
            return "Il y a "+ hours +" heures"
        }

        if(hours > 1 && min > 0){
            if(min > 1)
                return "Il y a "+ hours +" heures "+min+" minutes"
            else
                return "Il y a "+ hours +" heures "+min+" minute"
        }


        if(min > 1 ){
            return  "Il y a "+min+" minutes"
        }


        if(min == 1){
            return "Il y a "+  min+" minute"
        }

        return  "Il y a "+sec+" secondes"


    }


    @Override
    public String toString() {
        return "{" +
                '\"texte\"' + ':' +   '\"'+texte+'\"'+','+
                '\"typeNotification\"' + ':' +   '\"'+typeNotification+'\"'+
                '\"idObjet\"' + ':' +   '\"'+idObjet+'\"'+
                "}"

    }



}
