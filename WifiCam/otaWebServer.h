//
// OTA WEB server
//
// zf240908.1053
//
// Sources:
// https://lastminuteengineers.com/esp32-ota-web-updater-arduino-ide/

#include <WebServer.h>
#include <ESPmDNS.h>
#include <Update.h>


/*
 * Login page
 */
#include "otaLoginIndex.h"


/*
 * Server Index Page
 */
#include "otaServerIndex.h"


WebServer serverOTA(8080);

static void otaWebServer() {
  /*use mdns for host name resolution*/
  if (!MDNS.begin(zHOST)) {         //http://xxx.local
    Serial.println("Error setting up MDNS responder!");
    while (1) {
      delay(1000);
    }
  }
  Serial.println("mDNS responder started");

  /*return index page which is stored in serverIndex */
  serverOTA.on("/", HTTP_GET, []() {
    serverOTA.sendHeader("Connection", "close");
    serverOTA.send(200, "text/html", loginIndex);
  });
  serverOTA.on("/serverIndex", HTTP_GET, []() {
    serverOTA.sendHeader("Connection", "close");
    serverOTA.send(200, "text/html", serverIndex);
  });
  /*handling uploading firmware file */
  serverOTA.on("/update", HTTP_POST, []() {
    serverOTA.sendHeader("Connection", "close");
    serverOTA.send(200, "text/plain", (Update.hasError()) ? "FAIL" : "OK");
    ESP.restart();
  }, []() {
    HTTPUpload& upload = serverOTA.upload();
    if (upload.status == UPLOAD_FILE_START) {
      Serial.printf("Update: %s\n", upload.filename.c_str());
      if (!Update.begin(UPDATE_SIZE_UNKNOWN)) { //start with max available size
        Update.printError(Serial);
      }
    } else if (upload.status == UPLOAD_FILE_WRITE) {
      /* flashing firmware to ESP*/
      if (Update.write(upload.buf, upload.currentSize) != upload.currentSize) {
        Update.printError(Serial);
      }
    } else if (upload.status == UPLOAD_FILE_END) {
      if (Update.end(true)) { //true to set the size to the current progress
        Serial.printf("Update Success: %u\nRebooting...\n", upload.totalSize);
      } else {
        Update.printError(Serial);
      }
    }
  });
  serverOTA.begin();
}
