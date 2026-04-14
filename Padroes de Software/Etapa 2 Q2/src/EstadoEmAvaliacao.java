public class EstadoEmAvaliacao implements EstadoProcesso {

    @Override
    public void deferir(Processo processo) {
        processo.avisarInteressado(); // ação de saída
        processo.setEstado(new EstadoDeferido());
        System.out.println("Processo deferido.");
    }

    @Override
    public void indeferir(Processo processo) {
        processo.avisarInteressado(); // ação de saída
        processo.setEstado(new EstadoIndeferido());
        System.out.println("Processo indeferido.");
    }

    public void validar(Processo p){ erro(); }
    public void designar(Processo p){ erro(); }
    public void cancelar(Processo p){ erro(); }
    public void prazoLegal(Processo p){ erro(); }

    private void erro() {
        throw new IllegalStateException("Operação não permitida em Avaliação.");
    }
}
