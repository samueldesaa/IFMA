public class EstadoFechado implements EstadoProcesso {

    public void validar(Processo p){ erro(); }
    public void designar(Processo p){ erro(); }
    public void deferir(Processo p){ erro(); }
    public void indeferir(Processo p){ erro(); }
    public void cancelar(Processo p){ erro(); }
    public void prazoLegal(Processo p){ erro(); }

    private void erro() {
        throw new IllegalStateException("Processo já está fechado.");
    }
}
