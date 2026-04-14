public class LanchoneteJP extends Lanchonete {
    @Override
    public Sanduiche criarSanduiche() {
        return new SanduicheJP();
    }
}
