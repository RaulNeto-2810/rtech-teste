package com.example.solicitacoes_api.service;

import com.example.solicitacoes_api.model.Solicitacao;
import com.example.solicitacoes_api.repository.SolicitacaoRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SolicitacaoService {

    private final SolicitacaoRepository repository;

    public SolicitacaoService(SolicitacaoRepository repository) {
        this.repository = repository;
    }

    public Solicitacao criar(Solicitacao solicitacao) {
        if (solicitacao.getTipo() == null || solicitacao.getTipo().isBlank()) {
            throw new BadRequestException("Campo 'tipo' é obrigatório.");
        }
        if (solicitacao.getDescricao() == null || solicitacao.getDescricao().isBlank()) {
            throw new BadRequestException("Campo 'descricao' é obrigatório.");
        }

        // ao criar status é sempre Pendente
        solicitacao.setStatus("Pendente");
        return repository.salvar(solicitacao);
    }

    public List<Solicitacao> listar() {
        return repository.listar();
    }

    public Solicitacao buscarPorId(Long id) {
        return repository.buscarPorId(id)
                .orElseThrow(() -> new NotFoundException("Solicitação não encontrada para o id: " + id));
    }

    public Solicitacao atualizar(Long id, String descricao, String status) {
        Solicitacao s = buscarPorId(id);

        if (descricao != null && !descricao.isBlank()) {
            s.setDescricao(descricao);
        }

        if (status != null && !status.isBlank()) {
            validarStatus(status);
            s.setStatus(status);
        }

        return s;
    }

    public void excluir(Long id) {
        buscarPorId(id);
        repository.excluir(id);
    }

    private void validarStatus(String status) {
        if (!status.equals("Pendente") && !status.equals("Aprovada") && !status.equals("Rejeitada")) {
            throw new BadRequestException("Status inválido. Use: Pendente, Aprovada ou Rejeitada.");
        }
    }
}