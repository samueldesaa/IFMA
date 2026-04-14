public class EstadoGestacao implements EstadoProcesso {

    @Override
    public void validar(Processo processo) {
        processo.setEstado(new EstadoCriado());
        System.out.println("Processo criado.");
    }

    public void designar(Processo p){ erro(); }
    public void deferir(Processo p){ erro(); }
    public void indeferir(Processo p){ erro(); }
    public void cancelar(Processo p){ erro(); }
    public void prazoLegal(Processo p){ erro(); }

    private void erro() {
        throw new IllegalStateException("Operação não permitida em Gestação.");
    }
}
