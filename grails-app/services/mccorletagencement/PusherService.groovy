package mccorletagencement

import com.pusher.rest.Pusher
import grails.util.Environment

class PusherService {


    def push(String message) {
       def pusher

        if (Environment.current == Environment.DEVELOPMENT) {
           pusher = new Pusher("appIdDev", "key", "secret")
        }else{
            pusher = new Pusher("appIdProd", "key", "secret")
        }

        pusher.setCluster("us2")
        pusher.setEncrypted(true)
        pusher.trigger("my-channel", "my-event", Collections.singletonMap("message", message))

    }
}
