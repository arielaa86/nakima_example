package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class FournisseurServiceSpec extends Specification {

    FournisseurService fournisseurService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Fournisseur(...).save(flush: true, failOnError: true)
        //new Fournisseur(...).save(flush: true, failOnError: true)
        //Fournisseur fournisseur = new Fournisseur(...).save(flush: true, failOnError: true)
        //new Fournisseur(...).save(flush: true, failOnError: true)
        //new Fournisseur(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //fournisseur.id
    }

    void "test get"() {
        setupData()

        expect:
        fournisseurService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Fournisseur> fournisseurList = fournisseurService.list(max: 2, offset: 2)

        then:
        fournisseurList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        fournisseurService.count() == 5
    }

    void "test delete"() {
        Long fournisseurId = setupData()

        expect:
        fournisseurService.count() == 5

        when:
        fournisseurService.delete(fournisseurId)
        sessionFactory.currentSession.flush()

        then:
        fournisseurService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Fournisseur fournisseur = new Fournisseur()
        fournisseurService.save(fournisseur)

        then:
        fournisseur.id != null
    }
}
