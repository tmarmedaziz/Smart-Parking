package tn.supcom.services;

import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.ConfigProvider;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import tn.supcom.exceptions.UserAlreadyExistsException;
import tn.supcom.models.*;
import tn.supcom.repository.ParkingRepository;
import tn.supcom.repository.ParkingSlotRepository;
import tn.supcom.repository.UserRepository;

import javax.annotation.PostConstruct;
import javax.ejb.Startup;
import javax.ejb.Singleton;
import javax.inject.Inject;
import javax.net.ssl.SSLSocketFactory;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;

@Singleton
@Startup
public class MqttConnection {
    private static final Config config = ConfigProvider.getConfig();
    private  final  String uri =config.getValue("mqtt.uri",String.class) ;
    private  final  String  username=config.getValue("mqtt.username",String.class);
    private  final  String password=config.getValue("mqtt.password",String.class);

    @Inject
    private ParkingRepository parkingRepository;

    @Inject
    private ParkingSlotRepository parkingSlotRepository;

    @Inject
    private UserRepository userRepository;

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
            System.out.println("----------------------------------------------");
            System.out.println(client.getClientId());
            System.out.println("----------------------------------------------");

            MqttConnectOptions mqttConnectOptions = new MqttConnectOptions();
            mqttConnectOptions.setUserName("tmarmedaziz");
            mqttConnectOptions.setPassword("Supcom_Aziz_Aim@2022".toCharArray());
            mqttConnectOptions.setSocketFactory(SSLSocketFactory.getDefault()); // using the default socket factory
            mqttConnectOptions.setKeepAliveInterval(15);
            mqttConnectOptions.setConnectionTimeout(30);
            mqttConnectOptions.setAutomaticReconnect(true);
            client.connect(mqttConnectOptions);
            client.setCallback(new MqttCallback() {
                @Override
                // Called when the client lost the connection to the broker
                public void connectionLost(Throwable cause) {
                    System.out.println("\n --------------------------------------------------- \n");
                    System.out.println("CLIENT LOST CONNECTION " + cause);
                    System.out.println("\n --------------------------------------------------- \n");
                    try {
                        client.reconnect();
                    } catch (MqttException e) {
                        throw new RuntimeException(e);
                    }
                }
                /**
                 *
                 * @param topic
                 * @param message
                 * @javadoc this func is activated when new data is streamed
                 */

                @Override
                public void messageArrived(String topic, MqttMessage message) throws MqttException {
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
                        //System.out.println("slots : " +message + " is successfully added");
                        //parkingID/parkingslotID/setstate
                        List<String> msg = List.of(message.toString().split("/"));
                        Parking parking = parkingRepository.findById(Integer.valueOf(msg.get(0))).get();
                        List<ParkingSlot> parkingSlots = parkingSlotRepository.findByParkingId(parking.getId());
                        for(ParkingSlot parkingSlot:parkingSlots){
                            if (parkingSlot.getId().equals(Integer.valueOf(msg.get(1)))){
                                if (Integer.valueOf(msg.get(2)).equals(1)){
                                    parkingSlot.setState(SlotState.FULL);
                                } else {parkingSlot.setState(SlotState.EMPTY);}
                                System.out.println(parkingSlot.toString());
                                parkingSlotRepository.save(parkingSlot);
                            }
                        }
                    }

                    if(topic.equals("clients/clientid")){
                        String userId = String.valueOf(message);
                        System.out.println(userId);

                        Optional<User> user = userRepository.findByEmail(userId);
                        if (user.isPresent()){
//                            System.out.println(user.get().toString());
                            sendMessage(client, "1", "clients/clientauth");
                        }else {
                            System.out.println("this user do not exist");
                            sendMessage(client, "0", "clients/clientauth");
                        }

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
            client.subscribe("clients/clientid", 1);

            // client.subscribe("verification", 1);
        } catch (MqttException e) {

        }
    }
}