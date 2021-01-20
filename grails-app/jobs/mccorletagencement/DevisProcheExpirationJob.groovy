package mccorletagencement


class DevisProcheExpirationJob {


    DevisService devisService
    NotificationService notificationService

    static triggers = {
        cron name: 'DevisProcheExpirationJob', cronExpression: "0 0 1 * * ?"
    }

    def execute() {

        Devis.findAllByValideAndApprouveAndDeclineAndExpireAuto(true, false, false, false).forEach({ devis ->

            if (devis.expire()) {

                if(devis.tentativeContact <= 1){
                    devis.setExpireAuto(true)
                }

                devis.setDecline(true)
                devisService.save(devis)

            }
        })


        for (notification in notificationService.list()) {
            notificationService.delete(notification.getId())
        }


    }


}
