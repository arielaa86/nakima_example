import mccorletagencement.UtilisateurPasswordEncoderListener
import mccorletagencement.dataServices.IconsDataService

// Place your Spring DSL code here
beans = {
    utilisateurPasswordEncoderListener(UtilisateurPasswordEncoderListener)
    localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
        defaultLocale = new Locale("us","US");
        java.util.Locale.setDefault(defaultLocale);
    }

}
