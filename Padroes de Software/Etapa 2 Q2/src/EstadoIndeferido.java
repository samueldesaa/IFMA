public class EstadoIndeferido implements EstadoProcesso {

    @Override
    public void prazoLegal(Processo processo) {
        processo.setEstado(new EstadoFechado());
        System.out.println("Processo fechado após prazo legal.");
    }

    @Override
    public void designar(Processo processo) {
        processo.setEstado(new EstadoEmAvaliacao());
        System.out.println("Processo voltou para avaliação.");
    }

    public void validar(Processo p){ erro(); }
    public void deferir(Processo p){ erro(); }
    public void indeferir(Processo p){ erro(); }
    public void cancelar(Processo p){ erro(); }

    private void erro() {
        throw new IllegalStateException("Operação não permitida em Indeferido.");
    }
}
