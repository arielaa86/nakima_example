package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EtatProductionServiceSpec extends Specification {

    EtatProductionService etatProductionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new EtatProduction(...).save(flush: true, failOnError: true)
        //new EtatProduction(...).save(flush: true, failOnError: true)
        //EtatProduction etatProduction = new EtatProduction(...).save(flush: true, failOnError: true)
        //new EtatProduction(...).save(flush: true, failOnError: true)
        //new EtatProduction(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //etatProduction.id
    }

    void "test get"() {
        setupData()

        expect:
        etatProductionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<EtatProduction> etatProductionList = etatProductionService.list(max: 2, offset: 2)

        then:
        etatProductionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        etatProductionService.count() == 5
    }

    void "test delete"() {
        Long etatProductionId = setupData()

        expect:
        etatProductionService.count() == 5

        when:
        etatProductionService.delete(etatProductionId)
        sessionFactory.currentSession.flush()

        then:
        etatProductionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        EtatProduction etatProduction = new EtatProduction()
        etatProductionService.save(etatProduction)

        then:
        etatProduction.id != null
    }
}
