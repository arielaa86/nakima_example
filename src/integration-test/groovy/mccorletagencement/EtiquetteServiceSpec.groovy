package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EtiquetteServiceSpec extends Specification {

    EtiquetteService etiquetteService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Etiquette(...).save(flush: true, failOnError: true)
        //new Etiquette(...).save(flush: true, failOnError: true)
        //Etiquette etiquette = new Etiquette(...).save(flush: true, failOnError: true)
        //new Etiquette(...).save(flush: true, failOnError: true)
        //new Etiquette(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //etiquette.id
    }

    void "test get"() {
        setupData()

        expect:
        etiquetteService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Etiquette> etiquetteList = etiquetteService.list(max: 2, offset: 2)

        then:
        etiquetteList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        etiquetteService.count() == 5
    }

    void "test delete"() {
        Long etiquetteId = setupData()

        expect:
        etiquetteService.count() == 5

        when:
        etiquetteService.delete(etiquetteId)
        sessionFactory.currentSession.flush()

        then:
        etiquetteService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Etiquette etiquette = new Etiquette()
        etiquetteService.save(etiquette)

        then:
        etiquette.id != null
    }
}
