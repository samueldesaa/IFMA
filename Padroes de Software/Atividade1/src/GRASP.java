//class Pedido {
//    private List<Item> itens = new ArrayList<>();
//}
//
//class Main {
//    public static void main(String[] args) {
//        Item item = new Item("Caneta", 2);
//        Pedido pedido = new Pedido();
//        pedido.addItem(item);
//    }
//}


//class Pedido {
//    private List<Item> itens = new ArrayList<>();
//    public Item adicionarItem(String nome, int quantidade) {
//        Item item = new Item(nome, quantidade);
//        itens.add(item);
//        return item;
//    }
//}
//
//class Main {
//    public static void main(String[] args) {
//        Pedido pedido = new Pedido();
//        pedido.adicionarItem("Caneta", 2);
//    }
//}

//class Cliente {
//    private String nome;
//    private List<Pedido> pedidos;
//}
//
//class Main {
//    public static void main(String[] args) {
//        Cliente c = new Cliente();
//        double total = 0;
//        for (Pedido p : c.getPedidos()) {
//            total += p.getValor();
//        }
//    }
//}

//class Cliente {
//    private List<Pedido> pedidos;
//    public double calcularTotalPedidos() {
//        return pedidos.stream().mapToDouble(Pedido::getValor).sum();
//    }
//}
//
//class Main {
//    public static void main(String[] args) {
//        Cliente c = new Cliente();
//        double total = c.calcularTotalPedidos();
//    }
//}

//class Impressora {
//    public void imprimir(String texto) {
//        System.out.println("Imprimindo: " + texto);
//    }
//}
//
//class Pedido {
//    public void imprimirPedido() {
//        Impressora impressora = new Impressora();
//        impressora.imprimir("Pedido...");
//    }
//}

//interface ImpressoraIF {
//    void imprimir(String texto);
//}
//
//class Impressora implements ImpressoraIF {
//    public void imprimir(String texto) { System.out.println("Imprimindo: " + texto); }
//}
//
//class Pedido {
//    private ImpressoraIF impressora;
//    public Pedido(ImpressoraIF impressora) { this.impressora = impressora; }
//    public void imprimirPedido() { impressora.imprimir("Pedido..."); }
//}

//class Main {
//    public static void main(String[] args) {
//        Cliente c = new Cliente();
//        Pedido p = new Pedido();
//        p.adicionarItem("Caneta", 2);
//        p.calcularTotal();
//        p.imprimirPedido();
//    }
//}

//class PedidoController {
//    public void criarPedido(Cliente cliente, String item, int quantidade) {
//        Pedido pedido = new Pedido();
//        pedido.adicionarItem(item, quantidade);
//        pedido.calcularTotal();
//        pedido.imprimirPedido();
//    }
//}
//
//class Main {
//    public static void main(String[] args) {
//        PedidoController controller = new PedidoController();
//        controller.criarPedido(new Cliente(), "Caneta", 2);
//    }
//}

//class Pedido {
//    private List<Item> itens;
//    public void adicionarItem(Item i) { itens.add(i); }
//    public void salvarNoBanco() { }
//    public void imprimir() { System.out.println("Pedido..."); }
//}

//class Pedido {
//    private List<Item> itens;
//    public void adicionarItem(Item i) { itens.add(i); }
//}
//
//class PedidoRepository {
//    public void salvar(Pedido p) { }
//}
//
//class PedidoPrinter {
//    public void imprimir(Pedido p) { System.out.println("Pedido..."); }
//}
