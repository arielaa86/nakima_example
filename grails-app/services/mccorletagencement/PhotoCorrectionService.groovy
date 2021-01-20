package mccorletagencement

import grails.gorm.services.Service

@Service(PhotoCorrection)
interface PhotoCorrectionService {

    PhotoCorrection get(Serializable id)

    List<PhotoCorrection> list(Map args)

    Long count()

    void delete(Serializable id)

    PhotoCorrection save(PhotoCorrection photoCorrection)

}