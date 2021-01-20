package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class QuestionnaireServiceSpec extends Specification {

    QuestionnaireService questionnaireService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Questionnaire(...).save(flush: true, failOnError: true)
        //new Questionnaire(...).save(flush: true, failOnError: true)
        //Questionnaire questionnaire = new Questionnaire(...).save(flush: true, failOnError: true)
        //new Questionnaire(...).save(flush: true, failOnError: true)
        //new Questionnaire(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //questionnaire.id
    }

    void "test get"() {
        setupData()

        expect:
        questionnaireService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Questionnaire> questionnaireList = questionnaireService.list(max: 2, offset: 2)

        then:
        questionnaireList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        questionnaireService.count() == 5
    }

    void "test delete"() {
        Long questionnaireId = setupData()

        expect:
        questionnaireService.count() == 5

        when:
        questionnaireService.delete(questionnaireId)
        sessionFactory.currentSession.flush()

        then:
        questionnaireService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Questionnaire questionnaire = new Questionnaire()
        questionnaireService.save(questionnaire)

        then:
        questionnaire.id != null
    }
}
