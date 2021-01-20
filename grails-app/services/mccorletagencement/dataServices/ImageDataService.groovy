package mccorletagencement.dataServices

import grails.gorm.transactions.Transactional
import org.imgscalr.Scalr

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

@Transactional
class ImageDataService {

    def scaleImageBytes(def file) {

        InputStream stream = file.getInputStream();

        InputStream entrada = new ByteArrayInputStream(stream.getBytes());
        BufferedImage image = ImageIO.read(entrada);

        BufferedImage scaledImg = Scalr.resize(image, Scalr.Method.QUALITY, Scalr.Mode.FIT_TO_WIDTH,
                1024, 768, Scalr.OP_ANTIALIAS)
        ByteArrayOutputStream baos = new ByteArrayOutputStream()

        try{
            ImageIO.write(scaledImg, "jpg", baos)
        }catch (Exception e){
            ImageIO.write(scaledImg, "png", baos)
        }

        baos.flush()

        return baos.toByteArray()

    }
}
