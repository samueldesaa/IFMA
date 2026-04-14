//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        Numero n1 = new NumeroUm();
        n1.imprimir(); // 1
        System.out.println();

        Numero n2 = new DecoradorParenteses(new NumeroUm());
        n2.imprimir(); // (1)
        System.out.println();

        Numero n3 = new DecoradorColchetes(new NumeroUm());
        n3.imprimir(); // [1]
        System.out.println();

        Numero n4 = new DecoradorChaves(new NumeroUm());
        n4.imprimir(); // {1}
        System.out.println();

        Numero combinado1 = new DecoradorChaves(
                new DecoradorParenteses(
                        new NumeroUm()));
        combinado1.imprimir(); // {(1)}
        System.out.println();

        Numero combinado2 = new DecoradorChaves(
                new DecoradorColchetes(
                        new DecoradorParenteses(
                                new NumeroUm())));
        combinado2.imprimir(); // [{(1)}]
        System.out.println();
    }

}