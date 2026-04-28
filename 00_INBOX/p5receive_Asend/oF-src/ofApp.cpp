#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    Arduino.setup(SERIALPORT, BAUDRATE);
}

//--------------------------------------------------------------
void ofApp::update(){
    if (Arduino.available()) {
        char switchStatus = Arduino.readByte();
        if (switchStatus == SWITCH_PRESSED) {
            cout << "Switch pressed\n";
        } else if (switchStatus == SWITCH_RELEASED) {
            cout << "Switch released\n";
        } else { // should not happen
            cout << "Unknown message: " << switchStatus << "\n";
        }
    }
}

//--------------------------------------------------------------
void ofApp::draw(){

}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseScrolled(int x, int y, float scrollX, float scrollY){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){

}
