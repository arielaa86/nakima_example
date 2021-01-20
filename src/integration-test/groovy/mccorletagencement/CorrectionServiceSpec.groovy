package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CorrectionServiceSpec extends Specification {

    CorrectionService correctionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Correction(...).save(flush: true, failOnError: true)
        //new Correction(...).save(flush: true, failOnError: true)
        //Correction correction = new Correction(...).save(flush: true, failOnError: true)
        //new Correction(...).save(flush: true, failOnError: true)
        //new Correction(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //correction.id
    }

    void "test get"() {
        setupData()

        expect:
        correctionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Correction> correctionList = correctionService.list(max: 2, offset: 2)

        then:
        correctionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        correctionService.count() == 5
    }

    void "test delete"() {
        Long correctionId = setupData()

        expect:
        correctionService.count() == 5

        when:
        correctionService.delete(correctionId)
        sessionFactory.currentSession.flush()

        then:
        correctionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Correction correction = new Correction()
        correctionService.save(correction)

        then:
        correction.id != null
    }
}
