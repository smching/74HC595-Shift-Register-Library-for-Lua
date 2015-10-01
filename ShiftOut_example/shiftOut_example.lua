#!/usr/bin/lua
require "gpio"
require "shiftOut"
require "bit"

print("===== LSBFIRST =====")
for i= 0, Number_of_bit do
  value=nixio.bit.lshift(1,i)
  print("update_ShiftRegister("..value..",LSBFIRST)")
  update_ShiftRegister(value,LSBFIRST)
  delay(0.2)
end

print("===== MSBFIRST =====")
for i= 0, Number_of_bit do
  value=nixio.bit.lshift(1,i)
  print("update_ShiftRegister("..value..",MSBFIRST)")
  update_ShiftRegister(value,MSBFIRST)
  delay(0.2)
end

print("===== LSBFIRST =====")
for i= 0, Number_of_bit do
  value=nixio.bit.lshift(1,i)-1
  print("update_ShiftRegister("..value..",LSBFIRST)")
  update_ShiftRegister(value,LSBFIRST)
  delay(0.2)
end

print("===== MSBFIRST =====")
for i= 0, Number_of_bit do
  value=nixio.bit.lshift(1,i)-1
  print("update_ShiftRegister("..value..",MSBFIRST)")
  update_ShiftRegister(value,MSBFIRST)
  delay(0.2)
end

print("===== ALL OFF =====")
value=0
print("update_ShiftRegister("..value..",LSBFIRST)")
update_ShiftRegister(value,LSBFIRST)
