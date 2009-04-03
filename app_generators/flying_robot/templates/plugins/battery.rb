# Plugin for Ruby Arduino Development that reads a battery voltage from a power source that has been connected
# to one of the Arduino's analog pins. Note that you probably need to reduce the voltage considerably with a resistor (10K value?)
# before feeding it to the analog pin. You should also add another 10K resistor as a pull-down from the pin to ground.
#
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
# http://github.com/deadprogrammer/flying_robot
#
# Adapted from code written by Jordi Muñoz for the Blimpduino project 
# http://code.google.com/p/blimpduino/source/browse/trunk/BlimpDuino_v4.pde)
#
class Battery < ArduinoPlugin
  external_variables "float average_battery = 0.0"
  external_variables "bool battery_init_completed"
  
  add_to_setup "battery_init_completed = false;"
  
  # bogus function here to make RAD happy
  void battery_test() {
  }

  // initialize the battery reading
  void init_battery(int pin) {
    average_battery = analogRead(pin);
  }

  // get the current voltage
  // TODO: allow user to set constants for different expected battery voltages
  float voltage(int pin)
  {
    if (! battery_init_completed) {
      init_battery(pin);
    }
    
    average_battery=(((float) average_battery * 0.99) + (float)((float) analogRead(pin) * 0.01)); // Jordi called it dynamic average

    float battery_voltage=(float)((float) average_battery * (float)4.887586) * (float)2; // converting values to millivolts..,

    return battery_voltage ;
  }

end