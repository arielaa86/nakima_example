package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ActiviteServiceSpec extends Specification {

    ActiviteService activiteService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Activite(...).save(flush: true, failOnError: true)
        //new Activite(...).save(flush: true, failOnError: true)
        //Activite activite = new Activite(...).save(flush: true, failOnError: true)
        //new Activite(...).save(flush: true, failOnError: true)
        //new Activite(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //activite.id
    }

    void "test get"() {
        setupData()

        expect:
        activiteService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Activite> activiteList = activiteService.list(max: 2, offset: 2)

        then:
        activiteList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        activiteService.count() == 5
    }

    void "test delete"() {
        Long activiteId = setupData()

        expect:
        activiteService.count() == 5

        when:
        activiteService.delete(activiteId)
        sessionFactory.currentSession.flush()

        then:
        activiteService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Activite activite = new Activite()
        activiteService.save(activite)

        then:
        activite.id != null
    }
}
