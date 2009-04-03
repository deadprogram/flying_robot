# Plugin for Ruby Arduino Development that allows use of the Pololu micro dual serial motor controller
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# This is the device this plugin works with:
#   http://www.pololu.com/catalog/product/410
#
# Based on code taken from the Pololu forums: http://forum.pololu.com/viewtopic.php?f=15&t=1102&p=4913&hilit=arduino#p4913
class PololuMicroSerialController < ArduinoPlugin
  plugin_directives "#define LEFT_MOTOR  2"
  plugin_directives "#define RIGHT_MOTOR 3"
  
  plugin_directives "#define FORWARD 1"
  plugin_directives "#define REVERSE 0"

  external_variables "bool mc_init_complete"
  add_to_setup "mc_init_complete = false;"

  void pmsc_init(int motor_controller_reset_pin)
  {
    if (mc_init_complete) {
      return ;
    }
    
    mc_init_complete = true ;
      
    // start up motor controller
    digitalWrite(motor_controller_reset_pin, LOW);
    delay(10);
    digitalWrite(motor_controller_reset_pin, HIGH);

    // let motor controller wake up
    delay(100);
  }

  void pmsc_send_command(SoftwareSerial& motor_controller, byte motor, byte direction, byte speed)
  {
    unsigned char mc_command[4];
    direction = constrain(direction, 0,   1);
    speed     = constrain(speed,   0, 127);

    mc_command[0] = 0x80; // start byte
    mc_command[1] = 0x00; // Device type byte
    mc_command[2] = (2 * motor) + (direction == FORWARD ? FORWARD : REVERSE); // Motor number and direction byte
    mc_command[3] = speed; // Motor speed (0 to 127)

    // send data
    for(int i = 0; i < 4; i++)
    { motor_controller.print(mc_command[i], BYTE); }
  }

end