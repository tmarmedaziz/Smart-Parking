
# Smart-Parking
## Context: 
This project is being carried out within the context of the **Cloud of Things** module and is the collaboration of:
- Sirine Arfa
- Mohamed Aziz Tmar

with the tutorship of Dr. Ing. Mohamed-Bécha Kaâniche.

## Description: 
**Smart Parking**, powered by IoT technology, is making it easier for drivers to find free parking spots. Cities can better manage their parking assets and maximize the revenue available to them as a result. Drivers searching for parking create congestion and pollution by circling and hunting for available parking. Our Smart Parking solution intiteled **Modern Parker** provides services that are able to significantly ease these problems by guiding a driver directly to a parking space.

The goal of this project is the conception and realization of a full prototype of a smart parking with the ability to book and pay remotely which reduces the travel time, carbon emission, search time, traffic congestions in the city. In addition, it improves traffic flow within the parking lot with efficient design and creating a safer ecosystem for the guests.
This project will help us show the availability of car slots to park the vehicle. This is implemented by using **Raspberry Pi** and multiple sensors.
## Installation Guide:
## Technologies:
Multiple technologies, packages and hardware sensors were used in order to develop our his project, the technologies are diverse and used for backend and frontend development.
- Backend:
  - MongoDB
  - MQTT
  - Jakarta EE
  - WildFly
  - Other usefull Jakarta EE packages
- IoT:
  - Node RED
  - Communication protocols (I²C, SPI)
- Frontend
  - Flutter
- Server
  - Mosquitto Broker
- Hardware
  - Raspberry Pi 4
  - IR sensor
  - NFC/RFID reader
  - 12V Raspberry Pi power supply
![2](https://user-images.githubusercontent.com/80635318/213720751-26384d28-60df-411b-87d1-86fa093a9d0f.PNG) 
## Deployment Server:
We used our free Microsoft accounts in order to sign in and get 100$ offred by Microsoft Azure. This allowed us to create a virtual machine capable of hosting the Middleware (i.e. **Jakarta EE**), the MQTT Broker (i.e. **Mosquitto**) and handle several requests without delay. The characteristics of the virtual machine are as follow:
* Ram: 1 GB
* CPU: 1 GB
* Storage: 35 GB
The VM is hosted in East-Europe and top-notch internet connection.

## Sensors and the IoT prototype:
![Capture](https://user-images.githubusercontent.com/80635318/213831244-745a89a3-1f8e-4801-88bf-f1eee1ccfc44.PNG)

## Certification and Grading:
HTTPS was enabled using Let's Encrypt's Certbot, allowing us to verify the ownership of our domain **www.modernparker.me** and to make connections to our website secure. We also generated stronger Dephi-Helman parameters for the TLS connection with a length of 4096 bits. Thanks to this, and also thanks to some Jakarta EE parameters, we were able to disable **TLS 1.3** and enforce a stronger communication with our project. We were able to **grade A** validation from SSLLabs as Overall Rating.
![thumbnail_Capture d’écran 2023-01-20 154213](https://user-images.githubusercontent.com/80635318/213726218-17b709ac-3e25-4ec6-adb8-a671345040d7.png)
## Solution Screenshots:
![imags](https://user-images.githubusercontent.com/80635318/213830879-76435fc4-66d0-45fa-8d14-06947668e2a6.PNG)

## Further Readings:



