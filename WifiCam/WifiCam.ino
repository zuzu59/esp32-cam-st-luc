// Petite caméra de surveillance de St-Luc à base de mini caméra ESP32-cam
//
// ATTENTION, ce code a été testé sur un ESP32-cam. Pas testé sur les autres boards !
// Initial commit zf231111
//
#define zVERSION        "zf240908.1601"
#define zHOST           "esp-cam-st-luc"        // ATTENTION, tout en minuscule
#define zDSLEEP         0                       // 0 ou 1 !
#define TIME_TO_SLEEP   120                     // dSleep en secondes 
int zDelay1Interval =   5000;                   // Délais en mili secondes pour la boucle loop

/*
Utilisation:

Astuce:


Installation:

Pour les esp32-cam, il faut:
 * choisir comme board Ai Thinker ESP32-CAM
 * mettre le schéma de la partition à Regular 4MB with SPIFFS

Comme cet esp32 ne possède pas de connecteur USB avec convertisseur TTL il faut en ajouter un externe pour le premier flash, après on peut s'en passer en flashant via OTA
Et ponter le IO0 avec le GND pour se mettre en mode flashing !

Pour le WiFiManager, il faut installer cette lib depuis le lib manager sur Arduino:
https://github.com/tzapu/WiFiManager

Sources:
https://makeradvisor.com/esp32-cam-ov2640-camera/
https://fr.aliexpress.com/item/1005001322358029.html
https://randomnerdtutorials.com/esp32-cam-ai-thinker-pinout/
https://github.com/SeeedDocument/forum_doc/blob/master/reg/ESP32_CAM_V1.6.pdf
https://github.com/yoursunny/esp32cam/tree/main/examples/WifiCam

*/




// #define DEBUG true
// #undef DEBUG



// General
const int ledPin = 33;             // the number of the LED pin
//const int buttonPin = 9;          // the number of the pushbutton pin


// ESP32-cam
//#include "WifiCam.hpp"


// Sonar Pulse
#include "zSonarpulse.h"


// WIFI
#include "zWifi.h"


// OTA WEB server
#include "otaWebServer.h"


// Source: https://randomnerdtutorials.com/esp32-static-fixed-ip-address-arduino-ide/
// Set your Static IP address
IPAddress local_IP(192, 168, 1, 61);
// Set your Gateway IP address
IPAddress gateway(192, 168, 1, 1);

IPAddress subnet(255, 255, 255, 0);
IPAddress primaryDNS(8, 8, 8, 8);   //optional
IPAddress secondaryDNS(8, 8, 4, 4); //optional


// esp32cam::Resolution initialResolution;

//WebServer server(80);

void
setup(){
  // Pulse deux fois pour dire que l'on démarre
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW); delay(zSonarPulseOn); digitalWrite(ledPin, HIGH); delay(zSonarPulseOff);
  digitalWrite(ledPin, LOW); delay(zSonarPulseOn); digitalWrite(ledPin, HIGH); delay(zSonarPulseOff);
  delay(zSonarPulseWait);

  // Start serial console
  Serial.begin(19200);
  Serial.setDebugOutput(true);       //pour voir les messages de debug des libs sur la console série !
  delay(3000);                          //le temps de passer sur la Serial Monitor ;-)
  Serial.println("\n\n\n\n**************************************\nCa commence !"); Serial.println(zHOST ", " zVERSION);

  // Start WIFI
  zStartWifi();
  //sensorValue3 = WiFi.RSSI();

  // Start OTA server
  otaWebServer();

  // go go go
  Serial.println("\nC'est parti !\n");

  // using namespace esp32cam;
  // initialResolution = Resolution::find(1024, 768);
  // Config cfg;
  // cfg.setPins(pins::AiThinker);
  // cfg.setResolution(initialResolution);
  // cfg.setJpeg(80);

  // bool ok = Camera.begin(cfg);
  // if (!ok) {
  //   Serial.println("camera initialize failure");
  //   delay(5000);
  //   ESP.restart();
  // }
  // Serial.println("camera initialize success");
  // Serial.println("camera starting");
  // Serial.print("http://");
  // Serial.println(WiFi.localIP());

  // addRequestHandlers();
//  server.begin();
}




void loop() {
    // Délais non bloquant pour le serveur WEB et OTA
    zDelay1(zDelay1Interval);
}


    // Délais non bloquant pour le serveur WEB et OTA
void zDelay1(long zDelayMili){
  long zDelay1NextMillis = zDelayMili + millis(); 
  while(millis() < zDelay1NextMillis ){
    // WEB server
//    server.handleClient();
    // OTA loop
    serverOTA.handleClient();
    // Un petit coup de sonar pulse sur la LED pour dire que tout fonctionne bien
    sonarPulse();
    }

}
