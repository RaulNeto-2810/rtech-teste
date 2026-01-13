package com.example.solicitacoes_api.controller;

import com.example.solicitacoes_api.controller.dto.SolicitacaoUpdateRequest;
import com.example.solicitacoes_api.model.Solicitacao;
import com.example.solicitacoes_api.service.SolicitacaoService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/solicitacoes")
public class SolicitacaoController {

    private final SolicitacaoService service;

    public SolicitacaoController(SolicitacaoService service) {
        this.service = service;
    }

    // POST /solicitacoes
    @PostMapping
    public ResponseEntity<Solicitacao> criar(@RequestBody Solicitacao solicitacao) {
        Solicitacao criada = service.criar(solicitacao);
        return ResponseEntity.status(HttpStatus.CREATED).body(criada);
    }

    // GET /solicitacoes
    @GetMapping
    public ResponseEntity<List<Solicitacao>> listar() {
        return ResponseEntity.ok(service.listar());
    }

    // GET /solicitacoes/{id}
    @GetMapping("/{id}")
    public ResponseEntity<Solicitacao> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    // PUT /solicitacoes/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Solicitacao> atualizar(
            @PathVariable Long id,
            @RequestBody SolicitacaoUpdateRequest req
    ) {
        Solicitacao atualizada = service.atualizar(id, req.getDescricao(), req.getStatus());
        return ResponseEntity.ok(atualizada);
    }

    // DELETE /solicitacoes/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
