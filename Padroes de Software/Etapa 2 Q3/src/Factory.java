public class Factory {

    public static LocalidadeAbstractFactory newLocalidade(String localidade) {

        if ("Brasil".equalsIgnoreCase(localidade)) {
            return new LocalidadeBrasil();
        }
        if ("EUA".equalsIgnoreCase(localidade)) {
            return new LocalidadeEUA();
        }

        throw new IllegalArgumentException("Localidade inválida");
    }
}
