package mccorletagencement

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PhotoCorrectionServiceSpec extends Specification {

    PhotoCorrectionService photoCorrectionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new PhotoCorrection(...).save(flush: true, failOnError: true)
        //new PhotoCorrection(...).save(flush: true, failOnError: true)
        //PhotoCorrection photoCorrection = new PhotoCorrection(...).save(flush: true, failOnError: true)
        //new PhotoCorrection(...).save(flush: true, failOnError: true)
        //new PhotoCorrection(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //photoCorrection.id
    }

    void "test get"() {
        setupData()

        expect:
        photoCorrectionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<PhotoCorrection> photoCorrectionList = photoCorrectionService.list(max: 2, offset: 2)

        then:
        photoCorrectionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        photoCorrectionService.count() == 5
    }

    void "test delete"() {
        Long photoCorrectionId = setupData()

        expect:
        photoCorrectionService.count() == 5

        when:
        photoCorrectionService.delete(photoCorrectionId)
        sessionFactory.currentSession.flush()

        then:
        photoCorrectionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        PhotoCorrection photoCorrection = new PhotoCorrection()
        photoCorrectionService.save(photoCorrection)

        then:
        photoCorrection.id != null
    }
}
