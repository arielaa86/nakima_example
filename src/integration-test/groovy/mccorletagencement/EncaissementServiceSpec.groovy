package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EncaissementServiceSpec extends Specification {

    EncaissementService encaissementService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Encaissement(...).save(flush: true, failOnError: true)
        //new Encaissement(...).save(flush: true, failOnError: true)
        //Encaissement encaissement = new Encaissement(...).save(flush: true, failOnError: true)
        //new Encaissement(...).save(flush: true, failOnError: true)
        //new Encaissement(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //encaissement.id
    }

    void "test get"() {
        setupData()

        expect:
        encaissementService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Encaissement> encaissementList = encaissementService.list(max: 2, offset: 2)

        then:
        encaissementList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        encaissementService.count() == 5
    }

    void "test delete"() {
        Long encaissementId = setupData()

        expect:
        encaissementService.count() == 5

        when:
        encaissementService.delete(encaissementId)
        sessionFactory.currentSession.flush()

        then:
        encaissementService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Encaissement encaissement = new Encaissement()
        encaissementService.save(encaissement)

        then:
        encaissement.id != null
    }
}
