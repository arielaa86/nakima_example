package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EtatServiceSpec extends Specification {

    EtatService etatService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Etat(...).save(flush: true, failOnError: true)
        //new Etat(...).save(flush: true, failOnError: true)
        //Etat etat = new Etat(...).save(flush: true, failOnError: true)
        //new Etat(...).save(flush: true, failOnError: true)
        //new Etat(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //etat.id
    }

    void "test get"() {
        setupData()

        expect:
        etatService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Etat> etatList = etatService.list(max: 2, offset: 2)

        then:
        etatList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        etatService.count() == 5
    }

    void "test delete"() {
        Long etatId = setupData()

        expect:
        etatService.count() == 5

        when:
        etatService.delete(etatId)
        sessionFactory.currentSession.flush()

        then:
        etatService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Etat etat = new Etat()
        etatService.save(etat)

        then:
        etat.id != null
    }
}
