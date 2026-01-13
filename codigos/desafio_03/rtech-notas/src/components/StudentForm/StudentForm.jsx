
import { useEffect, useState } from "react";
import styles from "./StudentForm.module.css";

export default function StudentForm({ onSubmit, editingStudent }) {
    const [nome, setNome] = useState("");
    const [matricula, setMatricula] = useState("");

    useEffect(() => {
        // Preenche campos ao editar ou limpa ao adicionar novo
        if (editingStudent) {
            setNome(editingStudent.nome);
            setMatricula(editingStudent.matricula);
        } else {
            setNome("");
            setMatricula("");
        }
    }, [editingStudent]);

    function handleSubmit(e) {
        e.preventDefault();
        if (!nome || !matricula) return;

        // Chama função diferente dependendo se é edição ou adição
        if (editingStudent) {
            onSubmit(editingStudent.id, { nome, matricula });
        } else {
            onSubmit({ nome, matricula });
        }
        setNome("");
        setMatricula("");
    }

    return (
        <form className={styles.form} onSubmit={handleSubmit}>
            <h3>{editingStudent ? "Editar Aluno" : "Novo Aluno"}</h3>
            <input
                placeholder="Nome"
                value={nome}
                onChange={e => setNome(e.target.value)}
            />
            <input
                placeholder="Matrícula"
                value={matricula}
                onChange={e => setMatricula(e.target.value)}
            />
            <button>{editingStudent ? "Salvar" : "Adicionar"}</button>
        </form>
    );
}