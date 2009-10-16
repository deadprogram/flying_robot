# Plugin for Ruby Arduino Development that allows use of the L293D motor controller
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
#
class L293d < ArduinoPlugin
  plugin_directives "#define FORWARD 1"
  plugin_directives "#define REVERSE 0"

  void L293_send_command(int directionPin, int speedPin, byte direction, byte speed)
  {
    direction = constrain(direction, 0, 1);
    speed = constrain(speed, 0, 127);

    if (direction == FORWARD) {
      digitalWrite(directionPin, LOW);
      analogWrite(speedPin, speed);
    } else {
      speed = 255 - speed ;
      digitalWrite(directionPin, HIGH);
      analogWrite(speedPin, speed);
    }
  }

end