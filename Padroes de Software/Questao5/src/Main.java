public class Main {
    public static void main(String[] args) {

        Lanchonete cg = new LanchoneteCG();
        Lanchonete jp = new LanchoneteJP();
        Lanchonete rt = new LanchoneteRT();

        System.out.println("Sanduíche CG:");
        cg.criarSanduiche().mostrar();

        System.out.println("Sanduíche JP:");
        jp.criarSanduiche().mostrar();

        System.out.println("Sanduíche RT:");
        rt.criarSanduiche().mostrar();
    }
}
