package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import mccorletagencement.dataServices.ImageDataService
import org.imgscalr.Scalr

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN'])
class CorrectionController {

    CorrectionService correctionService
    PhotoCorrectionService photoCorrectionService
    ImageDataService imageDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond correctionService.list(params), model:[correctionCount: correctionService.count()]
    }

    def show(Long id) {
        respond correctionService.get(id)
    }

    def create() {
        respond new Correction(params)
    }

    def save() {

        def correction = new Correction()


        def facture = FactureClient.findById(params.factureId)

        correction.setDate(new Date())
        correction.setDescription(params.description)
        correction.setFactureClient(facture)

        correctionService.save(correction)

        println(params.document)

        request.getFiles("document").each { file ->

            String fileName = file.originalFilename

            if(fileName != "") {
                def photo = new PhotoCorrection()

                String[] arr = fileName.split("\\.")

                photo.setDocumentType(arr[arr.length - 1])

                def scaledImageInByte =  imageDataService.scaleImageBytes(file)

                photo.setDocument(scaledImageInByte)
                photo.setDate(new Date())
                photo.setCorrection(correction)

                photoCorrectionService.save(photo)
            }
        }

    }

    def edit(Long id) {
        respond correctionService.get(id)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
    def update() {

        def correction = correctionService.get(params.id)

        if(correction.corrige){
            correction.setCorrige(false)
        }else{
            correction.setCorrige(true)
        }

       correctionService.save(correction)

    }

    def delete() {
        correctionService.delete(params.id)
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'correction.label', default: 'Correction'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
