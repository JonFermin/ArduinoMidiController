// Code originally from http://www.instructables.com/id/Arduino-to-Processing-Serial-Communication-withou/
// by https://www.instructables.com/member/thelostspore/
// Code was shared under public domain https://creativecommons.org/licenses/publicdomain/

// This code reads analog inputs from pins A0 and A1 and sends these values out via serial
// You can add or remove pins to read from, but be sure they are separated by commas, and print a
// newline character at the end of each loop()

void setup() {
  Serial.begin(9600); //Begin Serial Communication with a baud rate of 9600
}
int Value1;
int Value2;
int Value3;
int Value4;
int Value5;
  
void loop() {
   //New variables are declared to store the readings of the respective pins

  Value1 = analogRead(A0);
  Value2 = analogRead(A1);
  Value3 = analogRead(A2);
  Value4 = analogRead(A3);
  Value5 = analogRead(A4);
  /*The Serial.print() function does not execute a "return" or a space
      Also, the "," character is essential for parsing the values,
      The comma is not necessary after the last variable.*/
//  
  Serial.print(Value1, DEC); 
  Serial.print(",");
  Serial.print(Value2, DEC);
  Serial.print(",");
  Serial.print(Value3, DEC);  
  Serial.print(",");
  Serial.print(Value4, DEC);
  Serial.print(",");
  Serial.print(Value5, DEC);
  Serial.println();
  //delay(500); // For illustration purposes only. This will slow down your program if not removed 
}
