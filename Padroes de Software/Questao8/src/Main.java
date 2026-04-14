public class Main {
    public static void main(String[] args) {

        Livro livro = new Livro.LivroBuilder("Java, como programar")
                .publicadoEm(2003)
                .dosAutores("H. M. Deitel", "P. J. Deitel")
                .edicao(4)
                .cidade("Porto Alegre")
                .editora("Bookman")
                .nomeOriginal("Java How to Program")
                .tradutores("Carlos Arthur Lang Lisbôa")
                .paginas(1386)
                .isbn(9788536301235L)
                .build();

        System.out.println(livro);
    }
}
