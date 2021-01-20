package mccorletagencement

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class Utilisateur implements Serializable {

    private static final long serialVersionUID = 1


    String username
    String password

    String nom
    String prenom
    String email
    String telephone
    byte[] signature

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    String code

    static hasMany = [projets: Projet, taches: Tache, activites: Activite, devisCree: Devis, facturesSigne: FactureClient]

    Set<Role> getAuthorities() {
        (UtilisateurRole.findAllByUtilisateur(this) as List<UtilisateurRole>)*.role as Set<Role>
    }

    static constraints = {
        password nullable: false, blank: false, password: true
        username nullable: false, blank: false, unique: true
        nom blank: false
        prenom blank: false
        email blank: false, email: true, unique: true
        telephone blank: false, matches:"[+]?[0-9 ]+", unique: true
        signature nullable: true
        code nullable: true
    }

    static mapping = {
	    password column: '`password`'
        id generator:'sequence', params:[sequence:'utilisateur_id_seq']
    }


    @Override
    public String toString() {
        return  prenom + " " +nom
    }


}
