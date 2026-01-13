import { useEffect, useState } from "react";
import styles from "./GradeForm.module.css";

export default function GradeForm({
    onSubmit,
    studentId,
    editingGrade,
    clearEdit
}) {
    const [disciplina, setDisciplina] = useState("");
    const [valor, setValor] = useState("");

    useEffect(() => {
        if (editingGrade) {
            setDisciplina(editingGrade.disciplina);
            setValor(editingGrade.valor);
        } else {
            setDisciplina("");
            setValor("");
        }
    }, [editingGrade]);

    function handleSubmit(e) {
        e.preventDefault();
        // Valida nota entre 0 e 10
        if (!disciplina || valor < 0 || valor > 10) return;

        if (editingGrade) {
            onSubmit(studentId, editingGrade.id, {
                disciplina,
                valor: Number(valor)
            });
        } else {
            onSubmit(studentId, {
                disciplina,
                valor: Number(valor)
            });
        }

        setDisciplina("");
        setValor("");
        clearEdit?.();
    }

    return (
        <form className={styles.form} onSubmit={handleSubmit}>
            <input
                placeholder="Disciplina"
                value={disciplina}
                onChange={e => setDisciplina(e.target.value)}
            />
            <input
                type="number"
                placeholder="Nota"
                value={valor}
                onChange={e => setValor(e.target.value)}
                min="0"
                max="10"
            />
            <button type="submit">{editingGrade ? "Salvar Nota" : "Adicionar Nota"}</button>
        </form>
    );
}
