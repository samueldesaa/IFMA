import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;

public class DataBrasil extends Data {

    @Override
    public String toString() {
        LocalDate hoje = LocalDate.now();
        return hoje.getDayOfWeek()
                .getDisplayName(TextStyle.SHORT, new Locale("pt", "BR"));
    }
}
