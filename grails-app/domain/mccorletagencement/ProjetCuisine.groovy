package mccorletagencement

class ProjetCuisine extends Projet {


  boolean coinRepas
  int nombrePersonne = 1
  String plaqueCuisson
  String bouteilleGaz
  boolean hotte  = false
  String evier
  String frigo
  boolean congelateur = false
  boolean four = false
  boolean microondes = false
  boolean laveVaisselle = false
  boolean laveLinge = false
  String planTravail
  String planTravailCouleur


    static constraints = {

      nombrePersonne min: 1
      plaqueCuisson inList: ['Gaz', 'Electrique', 'Mixte']
      bouteilleGaz inList: ['Néant', 'Intérieur', 'Extérieur']
      evier inList: ['1 Bac', '2 Bacs', '1 Cuve']
      frigo inList: ['Standard', 'Américain']
      planTravail inList: ['Néant','Quartz', 'Stratifié', 'Granite', 'Céramique' , 'Reysitop Compact' , 'Bois massif']
      planTravailCouleur nullable: true
    }

}
