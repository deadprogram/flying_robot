# Plugin for Ruby Arduino Development that allows use of the Pololu Qik 2s9v1 Serial controller
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# This is the device this plugin works with:
#   http://www.pololu.com/catalog/product/1110
# It may work with other Pololu motor controllers, but is NOT compatible with the Micro Serial Controller's command set
#
class PololuQikDualSerialMotorController < ArduinoPlugin
  plugin_directives "#define LEFT_MOTOR  2"
  plugin_directives "#define RIGHT_MOTOR 3"
  
  plugin_directives "#define FORWARD 1"
  plugin_directives "#define REVERSE 0"

  external_variables "bool mc_init_complete"
  add_to_setup "mc_init_complete = false;"

  void qik_init(int motor_controller_reset_pin, SoftwareSerial& motor_controller)
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
    
    // allow Pololu auto-baud rate detection to kick in
    // motor_controller.print(0xAA);
  }

  void qik_send_command(SoftwareSerial& motor_controller, byte motor, byte direction, byte speed)
  {
    unsigned char mc_command[4];
    direction = constrain(direction, 0,   1);
    speed     = constrain(speed,   0, 127);

    mc_command[0] = 0xAA;
    mc_command[1] = 0x09;
    
    if (motor == LEFT_MOTOR) {
      if (direction == FORWARD) {
        mc_command[2] = 0x88; // M0 forward
      } else {
        mc_command[2] = 0x8A; // M0 reverse
      }
    } else {
      if (direction == FORWARD) {
        mc_command[2] = 0x8C; // M1 forward
      } else {
        mc_command[2] = 0x8E; // M2 reverse
      }
    }

    mc_command[3] = speed; // Motor speed (0 to 127)

    // send data
    for(int i = 0; i < 4; i++)
    { motor_controller.print(mc_command[i], BYTE); }
  }

end