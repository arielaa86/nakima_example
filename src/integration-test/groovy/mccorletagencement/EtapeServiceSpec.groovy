package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EtapeServiceSpec extends Specification {

    EtapeService etapeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Etape(...).save(flush: true, failOnError: true)
        //new Etape(...).save(flush: true, failOnError: true)
        //Etape etape = new Etape(...).save(flush: true, failOnError: true)
        //new Etape(...).save(flush: true, failOnError: true)
        //new Etape(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //etape.id
    }

    void "test get"() {
        setupData()

        expect:
        etapeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Etape> etapeList = etapeService.list(max: 2, offset: 2)

        then:
        etapeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        etapeService.count() == 5
    }

    void "test delete"() {
        Long etapeId = setupData()

        expect:
        etapeService.count() == 5

        when:
        etapeService.delete(etapeId)
        sessionFactory.currentSession.flush()

        then:
        etapeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Etape etape = new Etape()
        etapeService.save(etape)

        then:
        etape.id != null
    }
}
