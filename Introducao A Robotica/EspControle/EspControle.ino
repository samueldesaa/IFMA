#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

// ================= SENSORES DE INCLINAÇÃO =================
#define SENSOR_FB 34   // Frente / Ré
#define SENSOR_R 35    // Direita
#define SENSOR_L 32    // Esquerda

// ================= BOTÃO DE ENVIO =================
#define BOTAO_ENVIO 12

// ================= LEDS =================
#define LED_B 25       // Liga quando SENSOR_FB estiver ativo
#define LED_R 26       // Liga quando SENSOR_R estiver ativo

// ================= BLUETOOTH =================
const char* NOME_CONTROLE = "FRANCIELE";

// MAC Bluetooth do carrinho: EC:E3:34:48:D1:DA
uint8_t enderecoCarrinho[] = { 0xEC, 0xE3, 0x34, 0x48, 0xD1, 0xDA };

// ================= CONTROLE DE CONEXÃO =================
unsigned long ultimaTentativa = 0;
const unsigned long intervaloTentativa = 3000;

bool conectado = false;

// ================= CONTROLE DE ENVIO =================
bool botaoAnterior = HIGH;

unsigned long ultimoEnvio = 0;
const unsigned long intervaloEnvio = 100;

char ultimoComandoEnviado = 'S';

void setup() {
  Serial.begin(115200);

  /*
    GPIO34 e GPIO35 são apenas entrada e NÃO possuem INPUT_PULLUP interno.
    Se o sensor de inclinação for módulo com DO, pode usar INPUT.
    Se for apenas a chave de mercúrio pura, precisa de resistor pull-up ou pull-down externo.
  */
  pinMode(SENSOR_FB, INPUT);
  pinMode(SENSOR_R, INPUT);

  // GPIO32 aceita INPUT_PULLUP
  pinMode(SENSOR_L, INPUT_PULLUP);

  pinMode(BOTAO_ENVIO, INPUT_PULLUP);

  pinMode(LED_B, OUTPUT);
  pinMode(LED_R, OUTPUT);

  digitalWrite(LED_B, LOW);
  digitalWrite(LED_R, LOW);

  // Mesmo PIN usado no carrinho
  SerialBT.setPin("1234", 4);

  // true = modo master, pois essa ESP32 vai conectar no carrinho
  SerialBT.begin(NOME_CONTROLE, true);

  delay(2000);

  Serial.println("Controle Bluetooth com sensores de inclinacao iniciado");
  Serial.print("Nome Bluetooth do controle: ");
  Serial.println(NOME_CONTROLE);

  conectarCarrinho();
}

void loop() {
  if (!SerialBT.connected()) {
    conectado = false;

    if (millis() - ultimaTentativa >= intervaloTentativa) {
      ultimaTentativa = millis();
      conectarCarrinho();
    }

    return;
  }

  conectado = true;

  char comandoAtual = lerComandoInclinacao();

  bool botaoAtual = digitalRead(BOTAO_ENVIO);

  // Botão pressionado = LOW, porque está com INPUT_PULLUP
  if (botaoAtual == LOW) {
    if (millis() - ultimoEnvio >= intervaloEnvio) {
      ultimoEnvio = millis();

      enviarComando(comandoAtual);
      ultimoComandoEnviado = comandoAtual;
    }
  }

  // Quando soltar o botão, envia S uma única vez
  if (botaoAnterior == LOW && botaoAtual == HIGH) {
    enviarComando('S');
    ultimoComandoEnviado = 'S';
    Serial.println("Botao solto: Parar");
    delay(100);
  }

  botaoAnterior = botaoAtual;
}

// ================= CONEXÃO BLUETOOTH =================

void conectarCarrinho() {
  Serial.println("Tentando conectar pelo MAC EC:E3:34:48:D1:DA...");

  conectado = SerialBT.connect(enderecoCarrinho);

  if (conectado) {
    Serial.println("Conectado ao carrinho!");
    enviarComando('S');
  } else {
    Serial.println("Falha ao conectar. Tentando novamente...");
  }
}

// ================= LEITURA DOS SENSORES =================

char lerComandoInclinacao() {
  int sensorFB = digitalRead(SENSOR_FB);
  int sensorR = digitalRead(SENSOR_R);
  int sensorL = digitalRead(SENSOR_L);

  /*
    Considerando:
    sensor ativo = HIGH
    sensor desativado = LOW

    D34 desativado = F
    D34 ativado = B + LED D25
    D35 ativado = R + LED D26
    D32 ativado = L
  */

  bool fbAtivo = sensorFB;
  bool rAtivo = !sensorR;
  bool lAtivo = !sensorL;

  digitalWrite(LED_B, fbAtivo);
  digitalWrite(LED_R, rAtivo);

  char comando = 'S';

  if (lAtivo) {
    comando = 'L';
  } 
  else if (rAtivo) {
    comando = 'R';
  } 
  else if (fbAtivo) {
    comando = 'F';
  } 
  else if(!fbAtivo){
    comando = 'B';
  }else{
    comando = 'S';
  }

  Serial.print("D34 FB: ");
  Serial.print(sensorFB);
  Serial.print(" | D35 R: ");
  Serial.print(sensorR);
  Serial.print(" | D32 L: ");
  Serial.print(sensorL);
  Serial.print(" | Botao: ");
  Serial.print(digitalRead(BOTAO_ENVIO));
  Serial.print(" | Comando atual: ");
  Serial.println(comando);

  return comando;
}

// ================= ENVIO =================

void enviarComando(char comando) {
  if (SerialBT.connected()) {
    SerialBT.write(comando);

    Serial.print("Enviado: ");
    Serial.println(comando);
  } else {
    Serial.println("Nao conectado. Comando nao enviado.");
  }
}