from dataclasses import dataclass
from typing import Dict, Optional

@dataclass
class Solicitacao:
    id: str
    tipo: str
    descricao: str
    status: str

db: Dict[str, Solicitacao] = {}

def ler_nao_vazio(mensagem: str) -> str:
    while True:
        valor = input(mensagem).strip()
        if valor:
            return valor
        print("Campo não pode ser vazio. Tente novamente.")

def buscar_por_id(solicitacao_id: str) -> Optional[Solicitacao]:
    return db.get(solicitacao_id)


def mostrar_menu() -> None:
    print("1 - Cadastrar nova solicitação")
    print("2 - Listar todas as solicitações")
    print("3 - Atualizar status por ID")
    print("4 - Excluir solicitação por ID")
    print("0 - Sair")

def cadastrar() -> None:
    solicitacao_id = ler_nao_vazio("\nID: ")
    if solicitacao_id in db:
        print("Erro: já existe uma solicitação com esse ID.\n")
        return

    tipo = ler_nao_vazio("Tipo: ")
    descricao = ler_nao_vazio("Descrição: ")
    status = input("Status (padrão: Pendente): ").strip() or "Pendente"

    db[solicitacao_id] = Solicitacao(
        id=solicitacao_id,
        tipo=tipo,
        descricao=descricao,
        status=status
    )
    print("Solicitação cadastrada com sucesso.\n")

def listar() -> None:
    if not db:
        print("Nenhuma solicitação cadastrada.\n")
        return

    print("\nLista de Solicitações")
    for s in db.values():
        print(f"- ID: {s.id} | Tipo: {s.tipo} | Status: {s.status}")
        print(f"  Descrição: {s.descricao} \n")

def atualizar_status() -> None:
    solicitacao_id = ler_nao_vazio("\nInforme o ID da solicitação: ")
    solicitacao = buscar_por_id(solicitacao_id)

    if not solicitacao:
        print("Erro: solicitação não encontrada.\n")
        return

    novo_status = ler_nao_vazio("Novo status: ")
    solicitacao.status = novo_status
    print("Status atualizado com sucesso.\n")

def excluir() -> None:
    solicitacao_id = ler_nao_vazio("\nInforme o ID para excluir: ")
    if solicitacao_id not in db:
        print("Erro: solicitação não encontrada.\n")
        return

    del db[solicitacao_id]
    print("Solicitação excluída com sucesso.\n")
def main() -> None:
    while True:
        mostrar_menu()
        opcao = input("Escolha uma opção: ").strip()

        if opcao == "1":
            cadastrar()
        elif opcao == "2":
            listar()
        elif opcao == "3":
            atualizar_status()
        elif opcao == "4":
            excluir()
        elif opcao == "0":
            print("Saindo...")
            break
        else:
            print("Opção inválida. Tente novamente.\n")

if __name__ == "__main__":
    main()