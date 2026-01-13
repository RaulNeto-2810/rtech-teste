import styles from "./StudentList.module.css";

export default function StudentList({
    students,
    selectedId,
    onSelect,
    onEdit,
    onDelete
}) {
    return (
        <ul className={styles.list}>
            {students.map(student => (
                <li
                    key={student.id}
                    className={student.id === selectedId ? styles.active : ""}
                >
                    <div className={styles.studentInfo} onClick={() => onSelect(student.id)}>
                        <span className={styles.studentName}>{student.nome}</span>
                        <span className={styles.studentMatricula}>Matrícula: {student.matricula}</span>
                    </div>
                    <div className={styles.actions}>
                        <button onClick={() => onEdit(student)}>
                            <ion-icon name="create-outline"></ion-icon>
                        </button>
                        <button onClick={() => onDelete(student.id)}>
                            <ion-icon name="trash-outline"></ion-icon>
                        </button>
                    </div>
                </li>
            ))}
        </ul>
    );
}