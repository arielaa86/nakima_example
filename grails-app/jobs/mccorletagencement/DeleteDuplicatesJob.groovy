package mccorletagencement

import groovy.sql.Sql

class DeleteDuplicatesJob {

    //TacheService tacheService
    def dataSource


    static triggers = {
        cron name: 'DeleteDuplicatesJob', cronExpression: "0 0 3 * * ?"
    }

    def execute() {


        String query = "DELETE FROM public.tache a USING public.tache b WHERE a.id < b.id AND a.date = b.date AND a.description = b.description"
        def sql = new Sql(dataSource)
        sql.executeUpdate(query)

/*
        Calendar cal = Calendar.getInstance()

        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        Date date = cal.getTime()


        def liste = Tache.findAllByDate(date)

        for (int i = liste.size() - 1; i > 0; i--) {

            if (liste.get(i).description == liste.get(i - 1).description &&
                    liste.get(i).creator == liste.get(i - 1).creator &&
                    liste.get(i).date.equals(liste.get(i - 1).date)) {

                tacheService.delete(liste.get(i).getId())

            }

        }

 */

    }


}
