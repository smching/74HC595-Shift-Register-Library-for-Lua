#!/usr/bin/lua
-- a lua library for sending data to 74HC595 Shift Registers
-- by http://ediy.com.my

require "gpio" -- Lua library to allow access to the GPIO
require "bit"  -- Bitfield operators and manipulation functions

---------- global variables
LatchPin = 20 --or LatchPin=GPIO[1] (refer gpio.lua global variables)
DataPin = 19 --or DataPin=GPIO[2]
ClockPin = 18 --or ClockPin=GPIO[3]
OutputEnablePin = 22 --or OutputEnablePin=GPIO[4]
Number_of_bit = 8 --use 16 for two 74HC595, 24 for three 74HC595, etc...
LSBFIRST = 1
MSBFIRST = 0

---------- configures the specified pin to behave as an output
pinMode(LatchPin, OUTPUT) 
pinMode(DataPin, OUTPUT) 
pinMode(ClockPin, OUTPUT) 
pinMode(OutputEnablePin, OUTPUT) 


---------- shiftOut function (sending data to 74HC595)
function shiftOut(dataPin, clockPin, bitOrder, val)
  for i = 0, Number_of_bit-1 do
    if bitOrder==MSBFIRST  then
	bitToSend=nixio.bit.band(val,nixio.bit.lshift(1,Number_of_bit-1-i))
    else
	bitToSend=nixio.bit.band(val,nixio.bit.lshift(1,i))
    end
    if bitToSend~=0 then bitToSend=1 end --convert non zero to 1

    digitalWrite(DataPin, bitToSend)
    digitalWrite(ClockPin, HIGH)
    digitalWrite(ClockPin, LOW)	
  end	
end


---------- binary to decimal number conversion
function binary_to_decimal(str)
  local result = 0
  local power=1
  for i = #str, 1, -1 do
    local c = str:sub(i,i)
    local i=tonumber(c)
    result = result+ i*power
    power=power*2
  end
  return(result)
end


---------- update Shift Register (decimal number)
function update_ShiftRegister(value, bitOrder)
  digitalWrite(LatchPin,LOW) -- write LOW(0) to the LatchPin
  shiftOut(DataPin, ClockPin, bitOrder, value)
  digitalWrite(LatchPin,HIGH) -- write HIGH(1) to the LatchPin
end


---------- update Shift Register (binary number)
function update_ShiftRegister_Binary(binary_number, bitOrder)
  local value = binary_to_decimal(binary_number)
  update_ShiftRegister(value, bitOrder)
end

