import java.util.Random;

class Pedido {
    private double valor;
    private boolean estoqueDisponivel;
    private boolean pagamentoProcessado;
    private boolean enviado;

    public Pedido(double valor, boolean estoqueDisponivel) {
        this.valor = valor;
        this.estoqueDisponivel = estoqueDisponivel;
    }

    public double getValor() {
        return valor;
    }

    public boolean isEstoqueDisponivel() {
        return estoqueDisponivel;
    }

    public boolean isPagamentoProcessado() {
        return pagamentoProcessado;
    }

    public void setPagamentoProcessado(boolean pagamentoProcessado) {
        this.pagamentoProcessado = pagamentoProcessado;
    }

    public boolean isEnviado() {
        return enviado;
    }

    public void setEnviado(boolean enviado) {
        this.enviado = enviado;
    }

    public void aplicarDesconto(double percentual) {
        this.valor -= this.valor * percentual;
    }
}

interface Handler {
    void setProximo(Handler proximo);
    void processar(Pedido pedido);
}

class VerificacaoEstoqueHandler implements Handler {
    private Handler proximo;

    @Override
    public void setProximo(Handler proximo) {
        this.proximo = proximo;
    }

    @Override
    public void processar(Pedido pedido) {
        if (pedido.isEstoqueDisponivel()) {
            System.out.println("Estoque disponível. Seguindo para o próximo passo...");
            if (proximo != null) proximo.processar(pedido);
        } else {
            System.out.println("Estoque indisponível. Pedido cancelado.");
        }
    }
}

class CalculoDescontoHandler implements Handler {
    private Handler proximo;

    @Override
    public void setProximo(Handler proximo) {
        this.proximo = proximo;
    }

    @Override
    public void processar(Pedido pedido) {
        double desconto = new Random().nextDouble() * 0.1;
        pedido.aplicarDesconto(desconto);
        System.out.printf("Desconto aplicado: %.2f%%. Valor atual: R$ %.2f%n", desconto * 100, pedido.getValor());
        if (proximo != null) proximo.processar(pedido);
    }
}

class PagamentoHandler implements Handler {
    private Handler proximo;

    @Override
    public void setProximo(Handler proximo) {
        this.proximo = proximo;
    }

    @Override
    public void processar(Pedido pedido) {
        pedido.setPagamentoProcessado(true);
        System.out.println("Pagamento processado com sucesso.");
        if (proximo != null) proximo.processar(pedido);
    }
}

class EnvioPedidoHandler implements Handler {
    private Handler proximo;

    @Override
    public void setProximo(Handler proximo) {
        this.proximo = proximo;
    }

    @Override
    public void processar(Pedido pedido) {
        if (pedido.isPagamentoProcessado()) {
            pedido.setEnviado(true);
            System.out.println("Pedido enviado ao cliente!");
        } else {
            System.out.println("Pagamento não processado. Pedido não enviado.");
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Pedido pedido1 = new Pedido(1000.0, true);
        Pedido pedido2 = new Pedido(500.0, false);

        Handler estoque = new VerificacaoEstoqueHandler();
        Handler desconto = new CalculoDescontoHandler();
        Handler pagamento = new PagamentoHandler();
        Handler envio = new EnvioPedidoHandler();

        estoque.setProximo(desconto);
        desconto.setProximo(pagamento);
        pagamento.setProximo(envio);

        System.out.println("Processando pedido 1:");
        estoque.processar(pedido1);

        System.out.println("\nProcessando pedido 2:");
        estoque.processar(pedido2);
    }
}
