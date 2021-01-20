package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class FactureFournisseurServiceSpec extends Specification {

    FactureFournisseurService factureFournisseurService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new FactureFournisseur(...).save(flush: true, failOnError: true)
        //new FactureFournisseur(...).save(flush: true, failOnError: true)
        //FactureFournisseur factureFournisseur = new FactureFournisseur(...).save(flush: true, failOnError: true)
        //new FactureFournisseur(...).save(flush: true, failOnError: true)
        //new FactureFournisseur(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //factureFournisseur.id
    }

    void "test get"() {
        setupData()

        expect:
        factureFournisseurService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<FactureFournisseur> factureFournisseurList = factureFournisseurService.list(max: 2, offset: 2)

        then:
        factureFournisseurList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        factureFournisseurService.count() == 5
    }

    void "test delete"() {
        Long factureFournisseurId = setupData()

        expect:
        factureFournisseurService.count() == 5

        when:
        factureFournisseurService.delete(factureFournisseurId)
        sessionFactory.currentSession.flush()

        then:
        factureFournisseurService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        FactureFournisseur factureFournisseur = new FactureFournisseur()
        factureFournisseurService.save(factureFournisseur)

        then:
        factureFournisseur.id != null
    }
}
