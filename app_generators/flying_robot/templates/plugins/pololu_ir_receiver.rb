# Plugin for Ruby Arduino Development that allows use of the Pololu IR Receiver Beacons
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# Based on code taken from the Blimpduino project: http://code.google.com/p/blimpduino/source/browse/trunk/InfraRed.pde
class PololuIrReceiver < ArduinoPlugin
  external_variables "unsigned long ir_count[4]"
  external_variables "int ir_beacon_direction = 0"
  external_variables "unsigned long ir_beacon_refresh_rate = 500"
  external_variables "unsigned long ir_beacon_last_reading_time = 0"
  
  # this function returns either 0, meaning the IR beacon was not found
  # or else 1 = Forward, 2 = Right, 3 = Back, 4 = Left
  int current_ir_beacon_direction() {
    return ir_beacon_direction ;
  }
    
  void reset_ir_receiver() {
    ir_count[0] = 0 ;
    ir_count[1] = 0 ;
    ir_count[2] = 0 ;
    ir_count[3] = 0 ;
    ir_beacon_last_reading_time = millis();
  }
  
  void finalize_ir_reading()
  { 
    ir_beacon_direction = 0 ;
       
    if(ir_count[0] + ir_count[1] + ir_count[2] + ir_count[3] > 10) {
      if(ir_count[1]>ir_count[0]) // counter 1 (right IR sensor) is greater than the counter 0 (forward ir sensor)
      {
        ir_beacon_direction|=0x01; // set the bit 1 in high   (0b00000001)
      } // if not leave it in cero (0b0000000). 

      if(ir_count[3]>ir_count[2]) // the counter 3 (left IR sensor) is greater than the counter 2 (back ir sensor)..  
      {
        ir_beacon_direction|=0x02; // Put the second bit of the variable in HIGH example: 0b00000010
      } // i f not leave it in cero.. 0b00000000

      if(ir_count[(ir_beacon_direction&0x01)] > ir_count[((ir_beacon_direction>>1)+2)]) // Now compare the to greatest counters either counter 0 or 1, vs. 2 or 3, 
      {
        ir_beacon_direction&=0x01;  //If yes, store the position of the > value, but eliminate the second bit and leave the first bit untouched.. 
      }
      else
      {
        ir_beacon_direction=((ir_beacon_direction>>1)+2);  //Eliminate the first bit and plus two...
      }
      
      ir_beacon_direction++;
    }
    
    reset_ir_receiver();
  }
  
  void update_ir_receiver(int front_pin, int right_pin, int back_pin, int left_pin) {
    if (millis() - ir_beacon_last_reading_time > ir_beacon_refresh_rate) {
      finalize_ir_reading();
    } else {
      if (digitalRead(front_pin) == LOW) {
        ir_count[0]++;
      }
      if (digitalRead(right_pin) == LOW) {
        ir_count[1]++;
      }
      if (digitalRead(back_pin) == LOW) {
        ir_count[2]++;
      }
      if (digitalRead(left_pin) == LOW) {
        ir_count[3]++;
      }
    }
  }
  
  
end
