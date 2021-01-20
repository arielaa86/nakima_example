package mccorletagencement.dataServices

import daos.TacheJourDTO
import grails.gorm.transactions.Transactional
import mccorletagencement.Tache
import mccorletagencement.Utilisateur

import java.text.SimpleDateFormat

@Transactional
class TacheDataService {

    def obtenirTaches(Utilisateur utilisateur, ArrayList<Tache> taches, ArrayList<TacheJourDTO> tachesSemaineDTO ) {

        Date date = new Date()
        String dateFormated = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).format(date)
        date = new SimpleDateFormat("dd MMMM yyyy", Locale.FRANCE).parse(dateFormated)

        Tache.findAllByDate(date).forEach({ tache ->

            if(tache.participe(utilisateur) == true){
                taches.add(tache)
            }
        })


        Calendar calendar = Calendar.getInstance()
        calendar.setTime(date)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        calendar.setFirstDayOfWeek(Calendar.MONDAY)
        calendar.set(Calendar.DAY_OF_WEEK, calendar.getFirstDayOfWeek())

        calendar.add(Calendar.SECOND, -1)

        def joursDeLaSemaine = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']


        for (int i = 0 ; i < joursDeLaSemaine.size(); i++){

            calendar.add(Calendar.DATE, 1)
            String dateString =  new SimpleDateFormat("dd MMM").format(calendar.getTime())
            joursDeLaSemaine.set(i , joursDeLaSemaine.get(i) + " "+dateString+"." )

        }



        calendar.setTime(date)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        calendar.setFirstDayOfWeek(Calendar.MONDAY)
        calendar.set(Calendar.DAY_OF_WEEK, calendar.getFirstDayOfWeek())

        calendar.add(Calendar.SECOND, -1);

        def dateMin = calendar.getTime()

        calendar.add(Calendar.SECOND, 1)
        calendar.add(Calendar.DATE, 6)

        def dateMax = calendar.getTime()


        for (int i = 1; i < 7; i++){
            tachesSemaineDTO.add( new TacheJourDTO(i))
        }

        Tache.findAllByDateBetween(dateMin, dateMax).forEach({ tache ->
            if(tache.participe(utilisateur) == true){

                calendar.setTime(tache.date)
                def xx = calendar.get(Calendar.DAY_OF_WEEK)
                def jour =  xx - 2
                tachesSemaineDTO.get(jour).getTaches().add(tache)

            }
        })


        return joursDeLaSemaine

    }
}
