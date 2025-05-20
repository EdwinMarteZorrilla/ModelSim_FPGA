// Pot and LED

const byte LED[] = {13,12,11,10};
#define Pot1 0

void setup()
{
Serial.begin(9600);
// initialize the digital pin as an output.
/* Set each pin to outputs */
pinMode(LED[0], OUTPUT);
pinMode(LED[1], OUTPUT);
pinMode(LED[2], OUTPUT);
pinMode(LED[3], OUTPUT);
}

/* Main Program */
void loop()
{
int PotValue;
//Serial.print('Potentiometer reading: ');
PotValue = analogRead(Pot1);
/* Wait 0.5 seconds before reading again */
if(PotValue < 400)
{
digitalWrite(LED[0], LOW);
digitalWrite(LED[1], LOW);
digitalWrite(LED[2], LOW);
digitalWrite(LED[3], LOW);
//Serial.print('Potentiometer: ');
Serial.println(PotValue);
}
else
{
digitalWrite(LED[0], HIGH);
digitalWrite(LED[1], HIGH);
digitalWrite(LED[2], HIGH);
digitalWrite(LED[3], HIGH);
//Serial.print('Potentiometer: ');
Serial.println(PotValue);
}
delay(500);
}
