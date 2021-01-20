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

@Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL'])
class PlanController {

    PlanService planService
    ProjetService projetService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond planService.list(params), model: [planCount: planService.count()]
    }

    def show(Long id) {
        respond planService.get(id)
    }

    def create() {
        session.actionName = params.actionName
        respond new Plan(params)
    }

    def save(Plan plan) {
        if (plan == null) {
            notFound()
            return
        }

        try {


            def projet = projetService.get(params.'projet.id')
            //def uploadedFileName = request.getFile("document")


            request.getFiles("document").each { file ->
                // log.debug(file.originalFilename) // persistence logic or logic as per requirement.

                String fileName = file.originalFilename

                def nouveauPlan = new Plan()

                String[] arr = fileName.split("\\.")

                nouveauPlan.setDocumentType(arr[arr.length - 1])

                nouveauPlan.setDocument(file.inputStream.bytes)
                nouveauPlan.setDate(new Date())
                nouveauPlan.setProjet(projet)
                planService.save(nouveauPlan)


            }

            flash.message = "Document ajouté"

            if (session.actionName.equals("show")) {

                if (projet.instanceOf(ProjetCuisine)) {
                    redirect action: 'show', controller: 'projetCuisine', params: ['id': projet.id]
                    return
                }

                if (projet.instanceOf(ProjetSalleBain)) {
                    redirect action: 'show', controller: 'projetSalleBain', params: ['id': projet.id]
                    return
                }

                if (projet.instanceOf(ProjetDressing)) {
                    redirect action: 'show', controller: 'projetDressing', params: ['id': projet.id]
                    return
                }

                if (projet.instanceOf(ProjetPlacard)) {
                    redirect action: 'show', controller: 'projetPlacard', params: ['id': projet.id]
                    return
                }

                if (projet.instanceOf(ProjetAutre)) {
                    redirect action: 'show', controller: 'projetAutre', params: ['id': projet.id]
                    return
                }

                if (projet.instanceOf(ProjetComplementaire)) {
                    redirect action: 'show', controller: 'projetComplementaire', params: ['id': projet.id]
                    return
                }
            }

            if (session.actionName.equals("modifierDocuments")) {

                def idProjet = session.idProjet
                def idProjetPrincipal = projetService.get(idProjet).projetPrincipal.id


                redirect action: 'modifierDocuments', controller: 'devis', params: ['id': idProjetPrincipal, idProjet: idProjet]
                return
            }


        } catch (ValidationException e) {
            respond plan.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'plan.label', default: 'Plan'), plan.id])
                redirect plan
            }
            '*' { respond plan, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond planService.get(id)
    }

    def update(Plan plan) {
        if (plan == null) {
            notFound()
            return
        }

        try {

            def uploadedFileName = request.getFile("document")
            String fileName = uploadedFileName.originalFilename

            String[] arr = fileName.split("\\.")

            plan.setDocumentType(arr[arr.length - 1])

            plan.setDate(new Date())

            planService.save(plan)
        } catch (ValidationException e) {
            respond plan.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'plan.label', default: 'Plan'), plan.id])
                redirect plan
            }
            '*' { respond plan, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        def projet = planService.get(id).getProjet()

        planService.delete(id)


        flash.message = "Document supprimé"


        if (params.actionName.equals("modifierDocuments")) {

            def idProjet = session.idProjet
            def idProjetPrincipal = projetService.get(idProjet).projetPrincipal.id

            redirect controller: 'devis', action: 'modifierDocuments', params: [id: idProjetPrincipal, idProjet: idProjet]

            return

        }

        redirect controller: 'projet', action: 'show', params: [id: projet.getId()]

        return

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'plan.label', default: 'Plan'), id])
                redirect controller: 'ProjetCuisine', action: 'show', params: [id: projet.getId()]
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'plan.label', default: 'Plan'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def showPlan() {

        def planId = params.id

        def plan = Plan.get(planId)

        response.outputStream << plan.document

        response.outputStream.flush()
        response.outputStream.close()

    }


    @Secured(['ROLE_ADMIN', 'ROLE_DIRECTEUR', 'ROLE_COMMERCIAL', 'ROLE_TECHNICIEN'])
    def showPlanPDF() {

        def planId = params.id

        def plan = Plan.get(planId)

        try {

                PDDocument document = PDDocument.load(plan.getDocument())
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
