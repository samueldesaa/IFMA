/*
  Robô seguidor de linha com ESP32
  Sensores:
  - LDR no D35
  - Sensor infravermelho no D34
  - Buzzer no D26

  Ponte H:
  - IN1 = D13
  - IN2 = D12
  - IN3 = D14
  - IN4 = D27
  - ENB_DIREITA = D32
  - ENA_ESQUERDA = D33
*/

// ================= PONTE H =================
const int IN1 = 13;
const int IN2 = 12;
const int IN3 = 14;
const int IN4 = 27;

// ================= PWM / ENABLE =================
const int ENB_DIREITA = 32;
const int ENA_ESQUERDA = 33;

// ================= SENSORES =================
const int LDR = 35;
const int SENSOR_IR = 34;
const int LED = 25;

// ================= BUZZER =================
const int buzzer = 26;

// ================= CONFIGURAÇÃO DOS SENSORES =================
// Agora o limite do LDR vai de 0 a 255
// Ajuste esse valor olhando o Serial Monitor
int limiteLDR = 1800;

// Altere para HIGH se o seu sensor IR detectar linha em HIGH
const int IR_LINHA = HIGH;

// ================= VELOCIDADES =================
int velocidade = 100;
int velocidadeCurva = 100;

// ================= CONTROLE =================
bool iniciou = false;

void setup() {
  Serial.begin(115200);

  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(LED, OUTPUT);

  pinMode(ENB_DIREITA, OUTPUT);
  pinMode(ENA_ESQUERDA, OUTPUT);

  pinMode(LDR, INPUT);
  pinMode(SENSOR_IR, INPUT);

  pinMode(buzzer, OUTPUT);

  parar();

  Serial.println("Robo seguidor de linha iniciado");
  Serial.println("Aguardando inicializacao...");

  iniciou = true;

  Serial.println("Comecando a andar...");
}

void loop() {
  if (!iniciou) {
    parar();
    return;
  }

  int leituraLDR = analogRead(LDR);

  // Converte a leitura do LDR de 0-4095 para 0-255
  // int ldrMapeado = map(leituraLDR,1000, 4096, 0, 255);
  // ldrMapeado = constrain(ldrMapeado, 0, 255);

  int leituraIR = digitalRead(SENSOR_IR);

  bool ldrNaLinha = leituraLDR > limiteLDR;
  bool irNaLinha = leituraIR == IR_LINHA;

  digitalWrite(LED, !ldrNaLinha);

  Serial.print("LDR bruto: ");
  Serial.print(leituraLDR);

  // Serial.print(" | LDR 0-255: ");
  // Serial.print(ldrMapeado);

  Serial.print(" | LDR linha: ");
  Serial.print(ldrNaLinha ? "SIM" : "NAO");

  Serial.print(" | IR: ");
  Serial.print(leituraIR);

  Serial.print(" | IR linha: ");
  Serial.print(irNaLinha ? "SIM" : "NAO");

  Serial.print(" | Acao: ");

  

  if (ldrNaLinha && irNaLinha) {
    parar();
    delay(50);
    apitarInicio();
    frente();
    delay(100);
    Serial.println("Frente");
  } 
  else if (ldrNaLinha && !irNaLinha) {
    girarEsquerda();
    delay(20);
    parar();
    Serial.println("Corrigindo esquerda");
  } 
  else if (!ldrNaLinha && irNaLinha) {
    girarDireita();
    delay(20);
    parar();
    Serial.println("Corrigindo direita");
  } 
  else {
    frente();
    Serial.println("Linha perdida");
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

  digitalWrite(IN2, HIGH);
  digitalWrite(IN1, LOW);

  digitalWrite(IN4, HIGH);
  digitalWrite(IN3, LOW);
}

void esquerda() {
  setVelocidade(velocidadeCurva, velocidade);

  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);

  digitalWrite(IN4, HIGH);
  digitalWrite(IN3, LOW);
}

void direita() {
  setVelocidade(velocidade, velocidadeCurva);

  digitalWrite(IN2, HIGH);
  digitalWrite(IN1, LOW);

  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
}

void re() {
  setVelocidade(velocidade, velocidade);

  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  digitalWrite(IN4, LOW);
  digitalWrite(IN3, HIGH);
}

void girarEsquerda() {
  setVelocidade(velocidade, velocidade);

  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);

  Serial.println("Girando para Esquerda");
}
void girarDireita() {
  setVelocidade(velocidade, velocidade);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);

  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);

  Serial.println("Girando para Direita");
}

void parar() {
  analogWrite(ENB_DIREITA, 0);
  analogWrite(ENA_ESQUERDA, 0);

  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);
}

// ================= BUZZER =================
void apitarInicio() {
  Serial.println("Apitando antes de iniciar...");

  analogWrite(buzzer, 180);
  delay(100);
  analogWrite(buzzer, 0);
  delay(100);

}