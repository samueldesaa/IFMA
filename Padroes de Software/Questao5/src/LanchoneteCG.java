public class LanchoneteCG extends Lanchonete {
    @Override
    public Sanduiche criarSanduiche() {
        return new SanduicheCG();
    }
}
