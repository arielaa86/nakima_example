package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ReponseServiceSpec extends Specification {

    ReponseService reponseService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Reponse(...).save(flush: true, failOnError: true)
        //new Reponse(...).save(flush: true, failOnError: true)
        //Reponse reponse = new Reponse(...).save(flush: true, failOnError: true)
        //new Reponse(...).save(flush: true, failOnError: true)
        //new Reponse(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //reponse.id
    }

    void "test get"() {
        setupData()

        expect:
        reponseService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Reponse> reponseList = reponseService.list(max: 2, offset: 2)

        then:
        reponseList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        reponseService.count() == 5
    }

    void "test delete"() {
        Long reponseId = setupData()

        expect:
        reponseService.count() == 5

        when:
        reponseService.delete(reponseId)
        sessionFactory.currentSession.flush()

        then:
        reponseService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Reponse reponse = new Reponse()
        reponseService.save(reponse)

        then:
        reponse.id != null
    }
}
