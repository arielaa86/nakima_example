package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CommentaireServiceSpec extends Specification {

    CommentaireService commentaireService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Commentaire(...).save(flush: true, failOnError: true)
        //new Commentaire(...).save(flush: true, failOnError: true)
        //Commentaire commentaire = new Commentaire(...).save(flush: true, failOnError: true)
        //new Commentaire(...).save(flush: true, failOnError: true)
        //new Commentaire(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //commentaire.id
    }

    void "test get"() {
        setupData()

        expect:
        commentaireService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Commentaire> commentaireList = commentaireService.list(max: 2, offset: 2)

        then:
        commentaireList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        commentaireService.count() == 5
    }

    void "test delete"() {
        Long commentaireId = setupData()

        expect:
        commentaireService.count() == 5

        when:
        commentaireService.delete(commentaireId)
        sessionFactory.currentSession.flush()

        then:
        commentaireService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Commentaire commentaire = new Commentaire()
        commentaireService.save(commentaire)

        then:
        commentaire.id != null
    }
}
