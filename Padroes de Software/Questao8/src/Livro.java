import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Livro {

    private String nomeNacional;
    private int ano;
    private List<String> autores;
    private int edicao;
    private String cidade;
    private String editora;
    private String nomeOriginal;
    private List<String> tradutores;
    private int paginas;
    private long isbn;

    private Livro() {
    }

    @Override
    public String toString() {
        return "Livro{" +
                "nomeNacional='" + nomeNacional + '\'' +
                ", ano=" + ano +
                ", autores=" + autores +
                ", edicao=" + edicao +
                ", cidade='" + cidade + '\'' +
                ", editora='" + editora + '\'' +
                ", nomeOriginal='" + nomeOriginal + '\'' +
                ", tradutores=" + tradutores +
                ", paginas=" + paginas +
                ", isbn=" + isbn +
                '}';
    }


    public static class LivroBuilder {

        private String nomeNacional;
        private int ano;
        private List<String> autores = new ArrayList<>();
        private int edicao;
        private String cidade;
        private String editora;
        private String nomeOriginal;
        private List<String> tradutores = new ArrayList<>();
        private int paginas;
        private long isbn;

        public LivroBuilder(String nomeNacional) {
            this.nomeNacional = nomeNacional;
        }

        public LivroBuilder publicadoEm(int ano) {
            this.ano = ano;
            return this;
        }

        public LivroBuilder dosAutores(String... autores) {
            this.autores.addAll(Arrays.asList(autores));
            return this;
        }

        public LivroBuilder edicao(int edicao) {
            this.edicao = edicao;
            return this;
        }

        public LivroBuilder cidade(String cidade) {
            this.cidade = cidade;
            return this;
        }

        public LivroBuilder editora(String editora) {
            this.editora = editora;
            return this;
        }

        public LivroBuilder nomeOriginal(String nomeOriginal) {
            this.nomeOriginal = nomeOriginal;
            return this;
        }

        public LivroBuilder tradutores(String... tradutores) {
            this.tradutores.addAll(Arrays.asList(tradutores));
            return this;
        }

        public LivroBuilder paginas(int paginas) {
            this.paginas = paginas;
            return this;
        }

        public LivroBuilder isbn(long isbn) {
            this.isbn = isbn;
            return this;
        }

        public Livro build() {
            Livro livro = new Livro();
            livro.nomeNacional = this.nomeNacional;
            livro.ano = this.ano;
            livro.autores = this.autores;
            livro.edicao = this.edicao;
            livro.cidade = this.cidade;
            livro.editora = this.editora;
            livro.nomeOriginal = this.nomeOriginal;
            livro.tradutores = this.tradutores;
            livro.paginas = this.paginas;
            livro.isbn = this.isbn;
            return livro;
        }
    }
}
