package mccorletagencement

import grails.gorm.transactions.Transactional
import org.apache.poi.openxml4j.opc.OPCPackage
import org.apache.poi.xwpf.usermodel.IBodyElement
import org.apache.poi.xwpf.usermodel.XWPFDocument
import org.apache.poi.xwpf.usermodel.XWPFTable

@Transactional
class DocumentOutilsService {

    public ArrayList<DocumentRow> readDocument(byte[] document) {

        File documentWord = new File("myfile")

        FileOutputStream fos

        fos = new FileOutputStream(documentWord)

        fos.write(document)
        fos.flush()
        fos.close()

        return readTables(documentWord)

    }



    private ArrayList<DocumentRow> readTables(File selectedFile){

        ArrayList<DocumentRow> rows = new ArrayList<>()

        try {
            FileInputStream fis = new FileInputStream(selectedFile);
            XWPFDocument xdoc = new XWPFDocument(OPCPackage.open(fis));

            Iterator bodyElementIterator = xdoc.getBodyElementsIterator();

            while (bodyElementIterator.hasNext()) {

                IBodyElement element = (IBodyElement) bodyElementIterator.next()

                if ("TABLE".equalsIgnoreCase(element.getElementType().name())) {
                    List<XWPFTable> tableList = element.getBody().getTables();

                    for (XWPFTable table : tableList) {

                        for (int i = 1; i < table.getRows().size(); i++) {

                            String nombre = table.getRow(i).getCell(0).getText()
                            String reference = table.getRow(i).getCell(1).getText()
                            String colonneF = table.getRow(i).getCell(2).getText()
                            String descriptif = table.getRow(i).getCell(3).getText()
                            String longueur = table.getRow(i).getCell(4).getText()
                            String profondeur = table.getRow(i).getCell(5).getText()
                            String hauteur = table.getRow(i).getCell(6).getText()
                            String quantite = table.getRow(i).getCell(7).getText()

                            DocumentRow row = new DocumentRow()

                            row.setNombre(nombre)
                            row.setReference(reference)
                            row.setColonneF(colonneF)
                            row.setDescriptif(descriptif)
                            row.setLongueur(longueur)
                            row.setProfondeur(profondeur)
                            row.setHauteur(hauteur)
                            row.setQuantite(quantite)

                            rows.add(row)

                        }
                  }
                    return rows
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }



}
