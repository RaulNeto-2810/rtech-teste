import { useState } from "react";
import GradeForm from "../GradeForm/GradeForm";
import styles from "./GradesPanel.module.css";

export default function GradesPanel({ student, onAdd, onUpdate, onDelete }) {
    const [editingGrade, setEditingGrade] = useState(null);

    // Calcula a média das notas ou retorna 0 se não houver notas
    const media =
        student.notas.reduce((acc, n) => acc + n.valor, 0) /
        student.notas.length || 0;

    return (
        <div className={styles.panel}>
            <h2>{student.nome} - Matrícula: {student.matricula}</h2>
            <p>Média: {media.toFixed(2)}</p>

            <GradeForm
                onSubmit={editingGrade ? onUpdate : onAdd}
                studentId={student.id}
                editingGrade={editingGrade}
                clearEdit={() => setEditingGrade(null)}
            />

            <ul>
                {student.notas.map(nota => (
                    <li key={nota.id}>
                        {nota.disciplina} — {nota.valor}
                        <div>
                            <button onClick={() => setEditingGrade(nota)}>
                                <ion-icon name="create-outline"></ion-icon>
                            </button>
                            <button onClick={() => onDelete(student.id, nota.id)}>
                                <ion-icon name="trash-outline"></ion-icon>
                            </button>
                        </div>
                    </li>
                ))}
            </ul>
        </div>
    );
}
