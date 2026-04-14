import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;

public class DataEUA extends Data {

    @Override
    public String toString() {
        LocalDate hoje = LocalDate.now();
        return hoje.getDayOfWeek()
                .getDisplayName(TextStyle.SHORT, Locale.ENGLISH);
    }
}
