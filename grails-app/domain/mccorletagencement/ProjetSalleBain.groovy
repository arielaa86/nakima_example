package mccorletagencement

class ProjetSalleBain extends Projet {

  String lavabo
  boolean laveLinge = false

  String planTravail
  String planTravailCouleur
  int quantitePieceEau = 1


    static constraints = {

      lavabo inList: ['Simple vasque', 'Double vasque']
      planTravail inList: ['Néant', 'Quartz', 'Stratifié', 'Granite', 'Céramique' , 'Reysitop Compact' , 'Bois massif']
      planTravailCouleur nullable: true
      quantitePieceEau min: 1

    }

}
