public class Processo {

    private EstadoProcesso estado;

    public Processo() {
        this.estado = new EstadoGestacao();
    }

    void setEstado(EstadoProcesso estado) {
        this.estado = estado;
    }

    void avisarInteressado() {
        System.out.println("Avisando interessado sobre o resultado da avaliação.");
    }

    // Delegação dos eventos
    public void validar() {
        estado.validar(this);
    }

    public void designar() {
        estado.designar(this);
    }

    public void deferir() {
        estado.deferir(this);
    }

    public void indeferir() {
        estado.indeferir(this);
    }

    public void cancelar() {
        estado.cancelar(this);
    }

    public void prazoLegal() {
        estado.prazoLegal(this);
    }
}
