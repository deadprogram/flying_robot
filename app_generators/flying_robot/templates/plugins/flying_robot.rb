# Plugin for Ruby Arduino Development that parses the flying_robot command set from any source of input to the serial port
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# In order to implement a sketch that uses the flying_robot parser, you need to implement the methods that make up its interface
# so that it will respond to the standard command set.
# 
# The following commands are supported:
# (h)ail - See if the UAV can still respond. Should send "Roger" back.
# (s)tatus - Grab a snapshot of all instrument readings plus any other status info that the UAV can support
# (e)levators - Set the elevators. The command supports two parameters:
#   direction - enter 'u' for up, 'c' for centered, or 'd' for down
#   deflection - enter an angle between 0 and 90 degrees
# (r)udder - Set the rudder. This command supports two parameters:
#   direction - enter 'l' for left, 'c' for centered, or 'r' for right
#   deflection - enter an angle between 0 and 90 degrees
# (a)ilerons - Set the ailerons. This command supports two parameters:
#   direction - enter 'l' for left, 'c' for centered, or 'r' for right
#   deflection - enter an angle between 0 and 90 degrees
# (t)hrottle - Set the throttle. This command supports two parameters:
#   direction - enter 'f' for forward, or 'r' for reverse
#   speed - enter a percentage from 0 to 100
# (i)nstruments - Read the current data for one of the installed instruments on the UAV. This command supports one parameter:
#   id - enter an integer for which instrment readings should be returned from. If there is not an instrument installed
#        for that id 'Invalid instrument' will be returned
# (p)rogram - Engage whatever autopilot program is available, if any. This command supports one parameter:
#   id - enter an integer for which autopilot routine should be used. Enter 0 to cancel autopilot
#
class FlyingRobot < ArduinoPlugin
  # used for parsing input commands
  external_variables "bool current_command_received_complete"
  external_variables "int current_command_length"
  external_variables "char command_buffer[120]"

  # the parsed command
  external_variables "char command_code[1]"
  external_variables "char direction_code[1]"
  external_variables "char instrument_code[1]"
  external_variables "char autopilot_code[1]"
  external_variables "int command_value"
    
  # current elevator values
  external_variables "char elevator_direction[1]"
  external_variables "int elevator_deflection = 0"
  
  # current rudder values
  external_variables "char rudder_direction[1]"
  external_variables "int rudder_deflection = 0"

  # current aileron values
  external_variables "char aileron_direction[1]"
  external_variables "int aileron_deflection = 0"
  
  # current throttle values
  external_variables "char throttle_direction[1]"
  external_variables "int throttle_speed = 0"
  
  # autopilot
  external_variables "bool autopilot_engaged"
    
  # initialize parser vars
  add_to_setup "current_command_received_complete = false; elevator_direction[0] = 'c'; rudder_direction[0] = 'c'; throttle_direction[0] = 'f'; autopilot_engaged = false;"
  
  # this is a hack to get the plugin included, that I got from the twitter_connect example
  void be_flying_robot(){}
  
  boolean current_command_received_is_complete() {
    return current_command_received_complete == true ;
  }
  
  char current_command() {
    return command_code[0];
  }

  char current_command_direction() {
    return direction_code[0];
  }

  char current_command_instrument() {
    return instrument_code[0];
  }

  char current_command_autopilot() {
    return autopilot_code[0];
  }
  
  int current_command_value() {
    return command_value ;
  }
  
  char current_elevator_direction() {
    return elevator_direction[0];
  }
  
  int current_elevator_deflection() {
    return elevator_deflection ;
  }

  char current_aileron_direction() {
    return aileron_direction[0];
  }
  
  int current_aileron_deflection() {
    return aileron_deflection ;
  }

  char current_rudder_direction() {
    return rudder_direction[0];
  }
  
  int current_rudder_deflection() {
    return rudder_deflection ;
  }

  char current_throttle_direction() {
    return throttle_direction[0];
  }
  
  int current_throttle_speed() {
    return throttle_speed ;
  }
  
  boolean is_autopilot_on() {
    return autopilot_engaged == true ;
  }
  
  void autopilot_on() {
    autopilot_engaged = true;
  }

  void autopilot_off() {
    autopilot_engaged = false;
  }
  
  void clear_command_buffer() {
    for(int i=0; i<120; i++){
      command_buffer[i] = 0 ;
    }
    
    command_code[0] = 0 ;
    direction_code[0] = 0 ;
    instrument_code[0] = 0 ;
    current_command_length = 0 ;
    current_command_received_complete = false ;
  }
  
  void parse_command_code() {
    if(current_command_length == 0) {
      command_code[0] = 0;
    } else {
      command_code[0] = command_buffer[0];
    }
  }

  void parse_direction_code() {
    if(current_command_length >= 3) {
      direction_code[0] = command_buffer[2];
    } else {
      direction_code[0] = 0;
    }
  }

  void parse_instrument_code() {
    if(current_command_length >= 3) {
      instrument_code[0] = command_buffer[2];
    } else {
      instrument_code[0] = 0;
    }
  }

  void parse_autopilot_code() {
    if(current_command_length >= 3) {
      autopilot_code[0] = command_buffer[2];
    } else {
      autopilot_code[0] = 0;
    }
  }

  void parse_command_value(int start) {
    if(current_command_length >= start + 1) {
      command_value = atoi(command_buffer + start);
    } else {
      command_value = 0 ;
    }
  }
  
  void get_command() {
    if(current_command_received_complete) {
      clear_command_buffer();
    }
    
    while(Serial.available() > 0) {
      command_buffer[current_command_length] = Serial.read();
      if(command_buffer[current_command_length] == '\r') {
        current_command_received_complete = true ;
        parse_command_code();
        return;
      } else {
        current_command_length++ ;
      }
    }
  }
  
  // used to echo the commands being received via serial
  void print_current_command(const char* cmd, int val) {
    Serial.print(cmd);
    Serial.print(" command - direction:");
    Serial.print(current_command_direction());
    Serial.print(" value:");
    Serial.println(val);    
  }
  
  void dispatch_command() {
    if(!current_command_received_is_complete()) {
      return;
    }
    
    char cmd = current_command(); 
    
    if (cmd == 'h') {
      hail();
    } else if (cmd == 's') {  
      status();
    } else if (cmd == 'e') {
      parse_direction_code();
      parse_command_value(4);
      elevator_direction[0] = current_command_direction();
      elevator_deflection = current_command_value();
      if (elevator_deflection > 90) {
        elevator_deflection = 90 ;
      }
      
      elevators();
    } else if (cmd == 'r') { 
      parse_direction_code();
      parse_command_value(4);
      rudder_direction[0] = current_command_direction();
      rudder_deflection = current_command_value();
      if (rudder_deflection > 90) {
        rudder_deflection = 90 ;
      }
      
      rudder();
    } else if (cmd == 'a') { 
      parse_direction_code();
      parse_command_value(4);
      aileron_direction[0] = current_command_direction();
      aileron_deflection = current_command_value();
      if (aileron_deflection > 90) {
        aileron_deflection = 90 ;
      }

      ailerons();
    } else if (cmd == 't') {
      parse_direction_code();
      parse_command_value(4);
      throttle_direction[0] = current_command_direction();
      throttle_speed = current_command_value();
      if (throttle_speed > 100) {
        throttle_speed = 100 ;
      }
      
      throttle();
    } else if (cmd == 'i') {    
      parse_instrument_code();
      instruments();
    } else if (cmd == 'p') {    
      parse_autopilot_code();
      if (autopilot_code[0] == '0') {
        autopilot_off();
      }
        
      autopilot();
    } else {    
      Serial.println("Invalid command");
    }    
  }
  
  void process_command() {
    get_command();
    dispatch_command();
  }
end