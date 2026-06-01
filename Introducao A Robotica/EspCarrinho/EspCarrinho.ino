#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

// ================= PONTE H =================
const int IN1 = 13;
const int IN2 = 12;
const int IN3 = 14;
const int IN4 = 27;

// ================= PWM / ENABLE =================
const int ENB_DIREITA = 32;
const int ENA_ESQUERDA = 33;

// ================= BUZZER =================
const int buzzer = 26;

// ================= BLUETOOTH =================
const char* NOME_BLUETOOTH = "ESP32_SAMUEL2OFICIAL";

// ================= VELOCIDADE =================
int velocidade = 250;

void setup() {
  Serial.begin(115200);

  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);

  pinMode(ENB_DIREITA, OUTPUT);
  pinMode(ENA_ESQUERDA, OUTPUT);

  pinMode(buzzer, OUTPUT);

  parar();
  analogWrite(buzzer, 0);

  // PIN de pareamento Bluetooth
  SerialBT.setPin("1234",4);

  // Carrinho em modo Bluetooth slave
  SerialBT.begin(NOME_BLUETOOTH);

  Serial.println("Carrinho Bluetooth iniciado");
  Serial.print("Nome Bluetooth: ");
  Serial.println(NOME_BLUETOOTH);
  Serial.println("PIN: 1234");
  Serial.println("Comandos:");
  Serial.println("F = Frente");
  Serial.println("B = Ré");
  Serial.println("L = Esquerda");
  Serial.println("R = Direita");
  Serial.println("S = Parar");
  Serial.println("Y = Buzzer");
}

void loop() {
  char comando = '\0';

  while (SerialBT.available()) {
    char c = SerialBT.read();

    // Ignora ENTER, quebra de linha, espaço e tab
    if (c != '\n' && c != '\r' && c != ' ' && c != '\t') {
      comando = c;
    }
  }

  if (comando != '\0') {
    comando = toupper(comando);

    Serial.print("Último comando recebido: ");
    Serial.println(comando);

    switch (comando) {
      case 'F':
        frente();
        break;

      case 'B':
        re();
        break;

      case 'L':
        girarEsquerda();
        break;

      case 'R':
        girarDireita();
        break;

      case 'S':
        parar();
        break;

      case 'Y':
        apitar();
        break;

      default:
        Serial.println("Comando inválido");

        if (SerialBT.hasClient()) {
          SerialBT.println("Comando inválido");
        }

        break;
    }
  }
}

// ================= VELOCIDADE =================
void setVelocidade(int velDireita, int velEsquerda) {
  velDireita = constrain(velDireita, 0, 255);
  velEsquerda = constrain(velEsquerda, 0, 255);

  analogWrite(ENB_DIREITA, velDireita);
  analogWrite(ENA_ESQUERDA, velEsquerda);
}

// ================= MOVIMENTOS =================
void frente() {
  setVelocidade(velocidade, velocidade);

  // Motor direita para frente
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  // Motor esquerda para frente
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  Serial.println("Frente");

  if (SerialBT.hasClient()) {
    SerialBT.println("Frente");
  }
}

void re() {
  setVelocidade(velocidade, velocidade);

  // Motor direita para trás
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);

  // Motor esquerda para trás
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);

  Serial.println("Ré");

  if (SerialBT.hasClient()) {
    SerialBT.println("Ré");
  }
}

void girarDireita() {
  setVelocidade(velocidade, velocidade);

  // Motor direita para trás
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);

  // Motor esquerda para frente
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  Serial.println("Girar direita");

  if (SerialBT.hasClient()) {
    SerialBT.println("Girar direita");
  }
}

void girarEsquerda() {
  setVelocidade(velocidade, velocidade);

  // Motor direita para frente
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  // Motor esquerda para trás
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);

  Serial.println("Girar esquerda");

  if (SerialBT.hasClient()) {
    SerialBT.println("Girar esquerda");
  }
}

void parar() {
  analogWrite(ENB_DIREITA, 0);
  analogWrite(ENA_ESQUERDA, 0);

  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);

  Serial.println("Parado");

  if (SerialBT.hasClient()) {
    SerialBT.println("Parado");
  }
}

void apitar() {
  analogWrite(buzzer, 180);
  delay(1000);
  analogWrite(buzzer, 0);

  Serial.println("Buzzer");

  if (SerialBT.hasClient()) {
    SerialBT.println("Buzzer");
  }
}