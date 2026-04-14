//interface Pagavel {
//    double calcularSalarioTotal();
//    void deposita(double valor);
//}
//
//class Chefe implements Pagavel {
//    public double getSalarioBase() { return 5000; }
//    public double getBonificacoes() { return 1000; }
//
//    public double calcularSalarioTotal() {
//        return getSalarioBase() + getBonificacoes();
//    }
//
//    public void deposita(double valor) {
//        System.out.println("Depositando " + valor + " na conta do Chefe");
//    }
//}
//
//class Funcionario implements Pagavel {
//    public double getSalario() { return 3000; }
//    public double getBonus() { return 500; }
//
//    public double calcularSalarioTotal() {
//        return getSalario() + getBonus();
//    }
//
//    public void deposita(double valor) {
//        System.out.println("Depositando " + valor + " na conta do Funcionário");
//    }
//}
//
//class Estagiario implements Pagavel {
//    public double getBolsa() { return 1500; }
//    public double getAuxilios() { return 200; }
//
//    public double calcularSalarioTotal() {
//        return getBolsa() + getAuxilios();
//    }
//
//    public void deposita(double valor) {
//        System.out.println("Depositando " + valor + " na conta do Estagiário");
//    }
//}
//
//class PagadorDeFuncionario {
//    public void paga(Pagavel pagavel) {
//        pagavel.deposita(pagavel.calcularSalarioTotal());
//    }
//}
//
//public class Main {
//    public static void main(String[] args) {
//        PagadorDeFuncionario pagador = new PagadorDeFuncionario();
//        Pagavel chefe = new Chefe();
//        Pagavel funcionario = new Funcionario();
//        Pagavel estagiario = new Estagiario();
//
//        pagador.paga(chefe);
//        pagador.paga(funcionario);
//        pagador.paga(estagiario);
//    }
//}
