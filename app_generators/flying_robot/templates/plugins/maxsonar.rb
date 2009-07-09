# Plugin for Ruby Arduino Development that allows use of the Maxbotix MaxSonar ultrasonic range finder
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# Based on code taken from the Blimpduino project: http://code.google.com/p/blimpduino/source/browse/trunk/Ultrasonic_Sensor.pde
class Maxsonar < ArduinoPlugin
  external_variables "unsigned long maxsonar_refresh_rate = 1000"
  external_variables "unsigned long maxsonar_last_reading_time = 0"
  external_variables "long last_maxsonar_distance = 0"
  external_variables "int ping_rx"
  external_variables "bool maxsonar_init_complete"
  
  add_to_setup "maxsonar_init_complete = false;"
  
  long maxsonar_distance () {
    return last_maxsonar_distance ;
  }
  
  void reset_maxsonar() {
    maxsonar_last_reading_time = millis();
  }
  
  void init_maxsonar(int reset_pin) {
    if (maxsonar_init_complete) {
      return ;
    }
    
    delay(250);
    digitalWrite(reset_pin, HIGH);
    delay(100);
    last_maxsonar_distance = 0;
    maxsonar_init_complete = true ;
  }

  int read_maxsonar(int an_pin) {
    int dist = 0 ;
    dist = analogRead(an_pin); 
    dist = (dist / 2); 
    return dist;
  }
  
  void update_maxsonar(int an_pin, int reset_pin) {
    init_maxsonar(reset_pin);
    
    if (millis() - maxsonar_last_reading_time > maxsonar_refresh_rate) {
      last_maxsonar_distance = read_maxsonar(an_pin);
    }
  }
  
  void init_maxsonar_pw(int reset_pin) {
    if (maxsonar_init_complete) {
      return ;
    }
    
    last_maxsonar_distance = 0;
    digitalWrite(reset_pin, HIGH);
    digitalWrite(reset_pin, LOW); // Activating MCU internal pull-down resistor
    digitalWrite(reset_pin, HIGH);
    delay(1000);
    maxsonar_init_complete = true ;
  }

  int read_maxsonar_pw(int pw_pin) {
    long pulse_length=0; //declaring variable
    digitalWrite(ping_rx, HIGH); 
    delay(37);
    pulse_length=pulseIn(pw_pin, HIGH); //pulseIn function to mesure the lenght of the pulse
    digitalWrite(ping_rx, LOW); 
    pulse_length = (pulse_length / 147); 
    return pulse_length;
  }
  
  void update_maxsonar_pw(int pw_pin, int reset_pin) {
    init_maxsonar_pw(reset_pin);
    
    if (millis() - maxsonar_last_reading_time > maxsonar_refresh_rate) {
      last_maxsonar_distance = read_maxsonar_pw(pw_pin);
    }
  }
  
end