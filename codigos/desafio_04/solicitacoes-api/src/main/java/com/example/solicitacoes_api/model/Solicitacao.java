package com.example.solicitacoes_api.model;

import java.time.LocalDateTime;

public class Solicitacao {

    private Long id;
    private String tipo;
    private String descricao;
    private String status;
    private LocalDateTime dataCriacao;

    public Solicitacao() {
        this.dataCriacao = LocalDateTime.now();
    }

    public Solicitacao(Long id, String tipo, String descricao, String status) {
        this.id = id;
        this.tipo = tipo;
        this.descricao = descricao;
        this.status = status;
        this.dataCriacao = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getDataCriacao() { return dataCriacao; }
}
