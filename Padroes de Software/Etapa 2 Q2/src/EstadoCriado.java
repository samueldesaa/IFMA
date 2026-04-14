public class EstadoCriado implements EstadoProcesso {

    @Override
    public void designar(Processo processo) {
        processo.setEstado(new EstadoEmAvaliacao());
        System.out.println("Processo em avaliação.");
    }

    @Override
    public void cancelar(Processo processo) {
        processo.setEstado(new EstadoFechado());
        System.out.println("Processo fechado.");
    }

    public void validar(Processo p){ erro(); }
    public void deferir(Processo p){ erro(); }
    public void indeferir(Processo p){ erro(); }
    public void prazoLegal(Processo p){ erro(); }

    private void erro() {
        throw new IllegalStateException("Operação não permitida em Criado.");
    }
}
