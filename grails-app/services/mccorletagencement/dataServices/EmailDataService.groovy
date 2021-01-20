package mccorletagencement.dataServices

import com.pusher.rest.Pusher
import grails.gorm.transactions.Transactional
import grails.plugins.mail.MailService
import grails.util.Environment
import mccorletagencement.Devis
import mccorletagencement.FactureClient
import mccorletagencement.OrdreProduction
import mccorletagencement.RapportComptable
import mccorletagencement.Role
import mccorletagencement.Utilisateur
import mccorletagencement.UtilisateurService

import java.util.logging.FileHandler
import java.util.logging.Logger
import java.util.logging.SimpleFormatter

@Transactional
class EmailDataService {

    MailService mailService
    UtilisateurService utilisateurService

   def sendEmailDevis(Devis devis) {

        File file = null

        if (Environment.current == Environment.DEVELOPMENT) {

             file = new File('./grails-app/assets/images/img/logomccorlet.jpg')

        }else{
            file = new File('/opt/images/logomccorlet.jpg')
        }


        println(devis.projet.concepteur.email)

        try {
            mailService.sendMail {
                multipart true
                to devis.projet.client.email
                subject "Votre devis MCCorlet Agencement est disponible"
                html(view: "/devis/emailDevis", model: [devis: devis])
                inline 'springsourceInlineImage', 'image/jpg', file
            }

        } catch (Exception ex) {

            Logger logger = Logger.getLogger("MyLog");
            FileHandler fh;

            try {

                // This block configure the logger with handler and formatter
                fh = new FileHandler("/opt/logs/MyLogFile.log");
                logger.addHandler(fh);
                SimpleFormatter formatter = new SimpleFormatter();
                fh.setFormatter(formatter);

                // the following statement is used to log any messages
                logger.info("Send devis by email log");

            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            logger.info(ex.toString());

            return false

        }

        return true
    }


    def sendEmailConfirmation(Devis devis) {

        try {
            mailService.sendMail {
                to devis.projet.concepteur.email
                subject "Confirmation d'envoi du devis No. " + devis.projet.idInsitu
                html(view: "/devis/mailConfirmationEnvoi", model: [devis: devis])
            }

        } catch (Exception ex) {


            Logger logger = Logger.getLogger("MyLog");
            FileHandler fh;

            try {

                // This block configure the logger with handler and formatter
                fh = new FileHandler("/opt/logs/MyLogFile1.log");
                logger.addHandler(fh);
                SimpleFormatter formatter = new SimpleFormatter();
                fh.setFormatter(formatter);

                // the following statement is used to log any messages
                logger.info("Send confirmation email log");

            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            logger.info(ex.toString());

            return false

        }

        return true
    }



    def sendEmailFactureAcquitte(Devis devis) {

        File file = null

        if (Environment.current == Environment.DEVELOPMENT) {

            file = new File('./grails-app/assets/images/img/logomccorlet.jpg')

        }else{
            file = new File('/opt/images/logomccorlet.jpg')
        }


        try {
            mailService.sendMail {
                multipart true
                to devis.projet.client.email
                subject "MCCorlet Agencement: Votre facture acquittée est disponible"
                html(view: "/factureClient/emailFactureAcquittee", model: ['devis': devis])
                inline 'springsourceInlineImage', 'image/jpg', file
            }

        } catch (Exception ex) {

            Logger logger = Logger.getLogger("MyLog");
            FileHandler fh;

            try {

                // This block configure the logger with handler and formatter
                fh = new FileHandler("/opt/logs/MyLogFile.log");
                logger.addHandler(fh);
                SimpleFormatter formatter = new SimpleFormatter();
                fh.setFormatter(formatter);

                // the following statement is used to log any messages
                logger.info("Send facture acquittee by email log");

            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            logger.info(ex.toString());

            return false

        }

        return true
    }


    def sendEmailConfirmationFactureAcquittee(Devis devis) {

        try {
            mailService.sendMail {
                to devis.projet.concepteur.email
                subject "Confirmation d'envoi de la facture acquittée No. " + devis.projet.idInsitu
                html(view: "/factureClient/mailConfirmationEnvoi", model: ['devis': devis])
            }

        } catch (Exception ex) {


            Logger logger = Logger.getLogger("MyLog");
            FileHandler fh;

            try {

                // This block configure the logger with handler and formatter
                fh = new FileHandler("/opt/logs/MyLogFile1.log");
                logger.addHandler(fh);
                SimpleFormatter formatter = new SimpleFormatter();
                fh.setFormatter(formatter);

                // the following statement is used to log any messages
                logger.info("Send confirmation facture acquittee email log");

            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            logger.info(ex.toString());

            return false

        }

        return true
    }


    def sendEmailRapport(RapportComptable rapport) {

        File file = null

        if (Environment.current == Environment.DEVELOPMENT) {

            file = new File('./grails-app/assets/images/img/logomccorlet.jpg')

        }else{
            file = new File('/opt/images/logomccorlet.jpg')
        }


        try {
            mailService.sendMail {
                multipart true

                if (Environment.current == Environment.DEVELOPMENT) {

                    to 'avila.dominfo@gmail.com'
                    cc 'arielaa86@gmail.com'

                }else{

                    to 'cc@lapigue.com'
                    cc 'direction.mccorlet@gmail.com '
                }

                subject "Rapport comptable mensuel de MCC"
                html(view: "/rapportComptable/mail", model: [rapport: rapport])
                inline 'springsourceInlineImage', 'image/jpg', file
            }

        } catch (Exception ex) {
            return false
        }

        return true
    }


    def emailRecupererMotPasse(Utilisateur utilisateur){

        def cal = Calendar.getInstance()
        cal.setTime(new Date())
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)

        def date = cal.getTime().toString()
        def id = utilisateur.getId().toString()

        def code = (id + date).sha256()
        utilisateur.setCode(code)

        utilisateurService.save(utilisateur)

        mailService.sendMail {
            async true
            to utilisateur.email
            subject "Récupération du mot de passe"
            html(view: "/utilisateur/emailRecupererMotPasse", model: ['code': code])
        }
    }



    def sendEmailOrdre(OrdreProduction ordre) {

        def destinataires = []
        Utilisateur.findAll().forEach({utilisateur ->
            if(utilisateur.authorities.contains(Role.findByAuthority("ROLE_TECHNICIEN"))){
                destinataires.add(utilisateur.getEmail())
            }
        })


        try {
            mailService.sendMail {
                async true
                to destinataires
                subject "Nouvel ordre de production"
                html(view: "/ordreProduction/mail", model: [ordre: ordre, texte: "Vous avez reçu un nouvel ordre de production"])
            }
        } catch (Exception ex) {
            return false
        }

        return true
    }




}
