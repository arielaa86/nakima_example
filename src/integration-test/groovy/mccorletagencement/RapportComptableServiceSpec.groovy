package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class RapportComptableServiceSpec extends Specification {

    RapportComptableService rapportComptableService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new RapportComptable(...).save(flush: true, failOnError: true)
        //new RapportComptable(...).save(flush: true, failOnError: true)
        //RapportComptable rapportComptable = new RapportComptable(...).save(flush: true, failOnError: true)
        //new RapportComptable(...).save(flush: true, failOnError: true)
        //new RapportComptable(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //rapportComptable.id
    }

    void "test get"() {
        setupData()

        expect:
        rapportComptableService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<RapportComptable> rapportComptableList = rapportComptableService.list(max: 2, offset: 2)

        then:
        rapportComptableList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        rapportComptableService.count() == 5
    }

    void "test delete"() {
        Long rapportComptableId = setupData()

        expect:
        rapportComptableService.count() == 5

        when:
        rapportComptableService.delete(rapportComptableId)
        sessionFactory.currentSession.flush()

        then:
        rapportComptableService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        RapportComptable rapportComptable = new RapportComptable()
        rapportComptableService.save(rapportComptable)

        then:
        rapportComptable.id != null
    }
}
