import java.text.NumberFormat;
import java.util.Locale;

public class MoedaBrasil extends Moeda {

    public MoedaBrasil(double valor) {
        super(valor);
    }

    @Override
    public String toString() {
        NumberFormat nf = NumberFormat.getCurrencyInstance(
                new Locale("pt", "BR"));
        return nf.format(valor);
    }
}
