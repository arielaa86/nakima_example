package mccorletagencement.dataServices

import daos.Result
import grails.gorm.transactions.Transactional
import mccorletagencement.Projet
import mccorletagencement.ProjetComplementaire
import mccorletagencement.Role
import mccorletagencement.Utilisateur
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class SearchDataService {

    def getResults(ArrayList<Result> resultats, String description) {

        def user = Utilisateur.findByUsername(SecurityContextHolder.getContext().getAuthentication().getName())

        def isDirecteur = user.authorities.contains(Role.findByAuthority("ROLE_DIRECTEUR"))

        def isComercial = user.authorities.contains(Role.findByAuthority("ROLE_COMMERCIAL"))


        if (description.matches("[0-9]+")) {


            Projet.findAllByIdInsituLike("%"+description+'%').forEach({ p ->

                    if(isComercial || isDirecteur ) {
                        Result rp = new Result()
                        rp.setDetail(p.idInsitu)
                        rp.setDescription("Projet")
                        rp.setController("projet")
                        rp.setAction("show")
                        rp.setId(p.id)
                        rp.setClient(p.client.toString())

                        resultats.add(rp)
                    }

                    if (p.devisClient != null) {

                        if (isDirecteur) {
                            Result rd = new Result()
                            rd.setDetail(p.idInsitu)
                            rd.setDescription("Devis")
                            rd.setController("devis")
                            rd.setAction("showDevisDir")
                            rd.setId(p.devisClient.id)
                            rd.setClient(p.client.toString())
                            resultats.add(rd)
                        }

                        if(isComercial && p.devisClient.facture == null ){
                            Result rd = new Result()
                            rd.setDetail(p.idInsitu)
                            rd.setDescription("Devis")
                            rd.setController("devis")
                            rd.setAction("show")
                            rd.setId(p.devisClient.id)
                            rd.setClient(p.client.toString())
                            resultats.add(rd)
                        }



                        if (p.devisClient.facture != null) {

                            if(isComercial || isDirecteur ) {
                                Result rf = new Result()
                                rf.setDetail(p.idInsitu)
                                rf.setDescription(p.devisClient.facture.isClosed() ? " Facture" : "Bon de commande")
                                rf.setController("factureClient")
                                rf.setAction("show")
                                rf.setId(p.devisClient.facture.id)
                                rf.setClient(p.client.toString())
                                resultats.add(rf)
                            }


                            if(!p.instanceOf(ProjetComplementaire)) {

                                if (p.devisClient.facture.ordreProduction != null) {
                                    Result ro = new Result()
                                    ro.setDetail(p.idInsitu)
                                    ro.setDescription("Ordre de production")
                                    ro.setController("ordreProduction")
                                    ro.setAction("show")
                                    ro.setId(p.devisClient.facture.ordreProduction.id)
                                    ro.setClient(p.client.toString())
                                    resultats.add(ro)
                                }
                            }
                        }




                    }



            })

        }

    }
}
