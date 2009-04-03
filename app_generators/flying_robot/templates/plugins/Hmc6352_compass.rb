# Plugin for Ruby Arduino Development that allows use of the HMC6352 Compass module
# Written by Ron Evans (http://deadprogrammersociety.com) for the flying_robot project
#
# Based on code taken from the SparkFun forums: http://forum.sparkfun.com/viewtopic.php?t=6236
class Hmc6352Compass < ArduinoPlugin
  include_wire
  
  external_variables "int HMC6352Address = 0x42"
  external_variables "byte headingData[2]"
  external_variables "int headingValue = 0"
  
  # Shift the device's documented slave address (0x42) 1 bit right
  # This compensates for how the TWI library only wants the
  # 7 most significant bits (with the high bit padded with 0)
  # This results in 0x21 as the address to pass to TWI
  external_variables "int slaveAddress = HMC6352Address >> 1"
  
  void prepare_compass() {
    // hack to reference plugin, copied this trick from twitter plugin 
  }
  
  // The whole number part of the heading
  int heading()
  {
    return int (headingValue / 10) ;
  }
  
  // The fractional part of the heading
  int heading_fractional()
  {
    return int (headingValue % 10) ;
  }
  
  void read_compass()
  {
    // Send a "A" command to the HMC6352
    // This requests the current heading data
    Wire.beginTransmission(slaveAddress);
    Wire.send("A");              // The "Get Data" command
    Wire.endTransmission();
    delay(10);                   // The HMC6352 needs at least a 70us (microsecond) delay
    // after this command.  Using 10ms just makes it safe
    // Read the 2 heading bytes, MSB first
    // The resulting 16bit word is the compass heading in 10ths of a degree
    // For example: a heading of 1345 would be 134.5 degrees
    Wire.requestFrom(slaveAddress, 2);        // Request the 2 byte heading (MSB comes first)
    int i = 0;
    while(Wire.available() && i < 2)
    { 
      headingData[i] = Wire.receive();
      i++;
    }
    headingValue = headingData[0]*256 + headingData[1];  // Put the MSB and LSB together
  } 
  
end