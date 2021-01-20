package mccorletagencement

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.rendering.ImageType
import org.apache.pdfbox.rendering.PDFRenderer

import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.nio.file.Files

import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_TECHNICIEN'])
class PhotoCorrectionController {

    PhotoCorrectionService photoCorrectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond photoCorrectionService.list(params), model:[photoCorrectionCount: photoCorrectionService.count()]
    }

    def show(Long id) {
        respond photoCorrectionService.get(id)
    }

    def create() {
        respond new PhotoCorrection(params)
    }

    def save(PhotoCorrection photoCorrection) {
        if (photoCorrection == null) {
            notFound()
            return
        }


        try {
        request.getFiles("document").each { file ->

            String fileName = file.originalFilename

            def photo = new PhotoCorrection()

            String[] arr = fileName.split("\\.")

            photo.setDocumentType(arr[arr.length-1])

            photo.setDocument(file.inputStream.bytes)
            photo.setDate(new Date())


            photoCorrectionService.save(photo)

        }

        } catch (ValidationException e) {
            respond photoCorrection.errors, view:'create'
            return
        }



        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'photoCorrection.label', default: 'PhotoCorrection'), photoCorrection.id])
                redirect photoCorrection
            }
            '*' { respond photoCorrection, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond photoCorrectionService.get(id)
    }

    def update(PhotoCorrection photoCorrection) {
        if (photoCorrection == null) {
            notFound()
            return
        }

        try {
            photoCorrectionService.save(photoCorrection)
        } catch (ValidationException e) {
            respond photoCorrection.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'photoCorrection.label', default: 'PhotoCorrection'), photoCorrection.id])
                redirect photoCorrection
            }
            '*'{ respond photoCorrection, [status: OK] }
        }
    }

    def delete() {

        def photo = photoCorrectionService.get( params.id )
        def facture = photo.correction.factureClient
        photoCorrectionService.delete(params.id)

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'photoCorrection.label', default: 'PhotoCorrection'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN' ])
    def showPhoto(){

        def photoId = params.id

        def photoCorrection = PhotoCorrection.get(photoId)

        response.outputStream << photoCorrection.document

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN' ])
    def showPDF(){

        def photoId = params.id

        def photoCorrection = PhotoCorrection.get(photoId)


        try {

            PDDocument document = PDDocument.load(photoCorrection.getDocument())
            PDFRenderer pdfRenderer = new PDFRenderer(document)

            BufferedImage image = pdfRenderer.renderImageWithDPI(0, 75, ImageType.RGB)

            ByteArrayOutputStream baos = new ByteArrayOutputStream()
            ImageIO.write( image, "png", baos )
            baos.flush()
            byte[] imageInByte = baos.toByteArray();
            baos.close()

            document.close()
            response.outputStream << imageInByte

            response.outputStream.flush()
            response.outputStream.close()


        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
