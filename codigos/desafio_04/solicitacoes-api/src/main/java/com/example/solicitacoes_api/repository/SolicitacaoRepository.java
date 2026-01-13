package com.example.solicitacoes_api.repository;

import com.example.solicitacoes_api.model.Solicitacao;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class SolicitacaoRepository {

    private final Map<Long, Solicitacao> banco = new HashMap<>();
    private Long idAtual = 1L;

    public Solicitacao salvar(Solicitacao solicitacao) {
        solicitacao.setId(idAtual++);
        banco.put(solicitacao.getId(), solicitacao);
        return solicitacao;
    }

    public List<Solicitacao> listar() {
        return new ArrayList<>(banco.values());
    }

    public Optional<Solicitacao> buscarPorId(Long id) {
        return Optional.ofNullable(banco.get(id));
    }

    public void excluir(Long id) {
        banco.remove(id);
    }
}