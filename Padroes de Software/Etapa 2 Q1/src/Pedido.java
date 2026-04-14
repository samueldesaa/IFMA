public class Pedido {

    private Estado estado;

    public Pedido() {
        this.estado = new EstadoProcessando(); // estado inicial
    }

    void setEstado(Estado estado) {
        this.estado = estado;
    }

    public void alterar() {
        estado.alterar(this);
    }

    public void cancelar() {
        estado.cancelar(this);
    }

    public void enviar() {
        estado.enviar(this);
    }

    // outros atributos e métodos do pedido
}
