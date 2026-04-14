public interface EstadoProcesso {

    void validar(Processo processo);
    void designar(Processo processo);
    void deferir(Processo processo);
    void indeferir(Processo processo);
    void cancelar(Processo processo);
    void prazoLegal(Processo processo);
}
