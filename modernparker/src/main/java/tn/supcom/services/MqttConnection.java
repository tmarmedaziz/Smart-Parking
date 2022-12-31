package tn.supcom.services;

import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.ConfigProvider;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

import javax.annotation.PostConstruct;
import javax.ejb.Startup;
import javax.ejb.Singleton;
import javax.net.ssl.SSLSocketFactory;

@Singleton
@Startup
public class MqttConnection {
//    private static final Config config = ConfigProvider.getConfig();
//    private  final  String uri =config.getValue("mqtt.uri",String.class) ;
//    private  final  String  username=config.getValue("mqtt.username",String.class);
//    private  final  String password=config.getValue("mqtt.password",String.class);


    /**
     *
     * @param client
     * @param msg
     * @param topic
     * @throws MqttException
     */

    public void sendMessage(MqttClient client, String msg, String topic) throws MqttException {
        MqttMessage message = new MqttMessage(msg.getBytes());
        client.publish(topic,message);
    }
    public void Hello(){
        System.out.println("Hello: ");
    }



    @PostConstruct
    public void start() {
        try {
            System.out.println("\n --------------------------------------------------- \n");

            System.out.println("MQTT HAS BEEN STARTED");
            System.out.println("\n --------------------------------------------------- \n");

            //CLIENT CONNECTION OPTIONS
            /**
             * uri=protocol://domain-name:port-number
             */
            MqttClient client = new MqttClient(
//                    uri,
                    "wss://mqtt.modernparker.me:8083",
                    MqttClient.generateClientId(),
                    new MemoryPersistence());

            MqttConnectOptions mqttConnectOptions = new MqttConnectOptions();
            mqttConnectOptions.setUserName("##");
            mqttConnectOptions.setPassword("##".toCharArray());
            mqttConnectOptions.setSocketFactory(SSLSocketFactory.getDefault()); // using the default socket factory
            client.connect(mqttConnectOptions);
            client.setCallback(new MqttCallback() {
                @Override
                // Called when the client lost the connection to the broker
                public void connectionLost(Throwable cause) {
                    System.out.println("\n --------------------------------------------------- \n");
                    System.out.println("CLIENT LOST CONNECTION " + cause);
                    System.out.println("\n --------------------------------------------------- \n");

                }
                /**
                 *
                 * @param topic
                 * @param message
                 * @javadoc this func is activated when new data is streamed
                 */

                @Override
                public void messageArrived(String topic, MqttMessage message) {
                    System.out.println("We are under message Arrived ");
                    System.out.println("\n-----------------------------------------------\n");
                    System.out.println(topic);
                    System.out.println("\n-----------------------------------------------\n");
                    //  System.out.println(message);
                    System.out.println("\n-----------------------------------------------\n");
                    //Todo : we  implement all the  logic  of saving the data  inside  the db and notifying users
                    if(topic.equals("parking")){
                        System.out.println("parking :"+ message+" is successfully added");


                    }if(topic.equals("parking/slots")){
                        System.out.println("slots : " +message + " is successfully added");

                    }
                }
                /**
                 *
                 * @param token
                 * @javadoc this func is activated when we produce data
                 */
                @Override
                public void deliveryComplete(IMqttDeliveryToken token) {
                    System.out.println("\n --------------------------------------------------- \n");
                    System.out.println("delivery complete " + token);
                }
            });


            client.subscribe("parking", 1);
            client.subscribe("parking/slots", 1);

            // client.subscribe("verification", 1);
        } catch (MqttException e) {

        }
    }
}