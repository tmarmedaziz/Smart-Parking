package tn.supcom.boundaries;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import tn.supcom.services.MqttConnection;

import javax.net.ssl.SSLSocketFactory;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Hashtable;

@ServerEndpoint("/mqtt")
public class BrokerResources {
    private MqttConnection mqttConnection;
    private static Hashtable<String, Session> sessions = new Hashtable<>();

    @OnOpen
    public void onOpen(Session session){
        mqttConnection.start();
        sessions.put(session.getId(), session); //add the new session

    }
    @OnClose
    public void onClose(Session session, CloseReason reason){
        sessions.remove(session); // delete sessions when client leave
    }
    @OnError
    public void onError(Session session, Throwable error){
        System.out.println("Push WebSocket error for ID " + session.getId() + ": " + error.getMessage());
    }


}
