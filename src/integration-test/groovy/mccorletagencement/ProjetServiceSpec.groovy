package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ProjetServiceSpec extends Specification {

    ProjetService projetService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Projet(...).save(flush: true, failOnError: true)
        //new Projet(...).save(flush: true, failOnError: true)
        //Projet projet = new Projet(...).save(flush: true, failOnError: true)
        //new Projet(...).save(flush: true, failOnError: true)
        //new Projet(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //projet.id
    }

    void "test get"() {
        setupData()

        expect:
        projetService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Projet> projetList = projetService.list(max: 2, offset: 2)

        then:
        projetList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        projetService.count() == 5
    }

    void "test delete"() {
        Long projetId = setupData()

        expect:
        projetService.count() == 5

        when:
        projetService.delete(projetId)
        sessionFactory.currentSession.flush()

        then:
        projetService.count() == 4
    }

    void "test save"() {

    }
}
