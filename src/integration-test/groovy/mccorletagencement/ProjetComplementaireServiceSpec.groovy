package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ProjetComplementaireServiceSpec extends Specification {

    ProjetComplementaireService projetComplementaireService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ProjetComplementaire(...).save(flush: true, failOnError: true)
        //new ProjetComplementaire(...).save(flush: true, failOnError: true)
        //ProjetComplementaire projetComplementaire = new ProjetComplementaire(...).save(flush: true, failOnError: true)
        //new ProjetComplementaire(...).save(flush: true, failOnError: true)
        //new ProjetComplementaire(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //projetComplementaire.id
    }

    void "test get"() {
        setupData()

        expect:
        projetComplementaireService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ProjetComplementaire> projetComplementaireList = projetComplementaireService.list(max: 2, offset: 2)

        then:
        projetComplementaireList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        projetComplementaireService.count() == 5
    }

    void "test delete"() {
        Long projetComplementaireId = setupData()

        expect:
        projetComplementaireService.count() == 5

        when:
        projetComplementaireService.delete(projetComplementaireId)
        sessionFactory.currentSession.flush()

        then:
        projetComplementaireService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ProjetComplementaire projetComplementaire = new ProjetComplementaire()
        projetComplementaireService.save(projetComplementaire)

        then:
        projetComplementaire.id != null
    }
}
