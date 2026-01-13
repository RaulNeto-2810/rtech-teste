import { useState } from "react";
import StudentForm from "./components/StudentForm/StudentForm";
import StudentList from "./components/StudentList/StudentList";
import GradesPanel from "./components/GradesPanel/GradesPanel";
import styles from "./App.module.css";

export default function App() {
  const [students, setStudents] = useState([]);
  const [selectedStudentId, setSelectedStudentId] = useState(null);
  const [editingStudent, setEditingStudent] = useState(null);
  const selectedStudent = students.find(s => s.id === selectedStudentId);

  function addStudent(data) {
    // validação para evitar duplicatas
    const exists = students.some(
      s => s.nome.toLowerCase() === data.nome.toLowerCase() &&
        s.matricula.toLowerCase() === data.matricula.toLowerCase()
    );

    if (exists) {
      alert('Já existe um aluno com este nome e matrícula.');
      return;
    }

    // adiciona novo aluno com ID único e array vazio de notas
    setStudents(prev => [
      ...prev,
      { id: crypto.randomUUID(), ...data, notas: [] }
    ]);
  }

  function updateStudent(id, data) {
    // verifica duplicatas excluindo o próprio aluno sendo editado
    const exists = students.some(
      s => s.id !== id &&
        s.nome.toLowerCase() === data.nome.toLowerCase() &&
        s.matricula.toLowerCase() === data.matricula.toLowerCase()
    );

    if (exists) {
      alert('Já existe outro aluno com este nome e matrícula.');
      return;
    }

    setStudents(prev =>
      prev.map(s => (s.id === id ? { ...s, ...data } : s))
    );
    // limpa o estado de edição após salvar
    setEditingStudent(null);
  }

  function deleteStudent(id) {
    setStudents(prev => prev.filter(s => s.id !== id));
    // limpa a seleção se o aluno deletado estava selecionado
    if (id === selectedStudentId) setSelectedStudentId(null);
  }

  function addGrade(studentId, grade) {
    const student = students.find(s => s.id === studentId);
    // cada disciplina só pode ter uma nota por aluno
    const exists = student?.notas.some(
      n => n.disciplina.toLowerCase() === grade.disciplina.toLowerCase()
    );

    if (exists) {
      alert('Já existe uma nota cadastrada para esta disciplina.');
      return;
    }

    // adiciona nova nota ao array de notas do aluno específico
    setStudents(prev =>
      prev.map(s =>
        s.id === studentId
          ? { ...s, notas: [...s.notas, { id: crypto.randomUUID(), ...grade }] }
          : s
      )
    );
  }

  function updateGrade(studentId, gradeId, data) {
    const student = students.find(s => s.id === studentId);
    // verifica se outra nota já usa essa disciplina (exclui a nota sendo editada)
    const exists = student?.notas.some(
      n => n.id !== gradeId &&
        n.disciplina.toLowerCase() === data.disciplina.toLowerCase()
    );

    if (exists) {
      alert('Já existe outra nota cadastrada para esta disciplina.');
      return;
    }

    // atualiza apenas a nota específica do aluno
    setStudents(prev =>
      prev.map(s =>
        s.id === studentId
          ? {
            ...s,
            notas: s.notas.map(n =>
              n.id === gradeId ? { ...n, ...data } : n
            )
          }
          : s
      )
    );
  }

  function deleteGrade(studentId, gradeId) {
    // remove a nota do array de notas do aluno
    setStudents(prev =>
      prev.map(s =>
        s.id === studentId
          ? { ...s, notas: s.notas.filter(n => n.id !== gradeId) }
          : s
      )
    );
  }

  return (
    <div className={styles.container}>
      {/* sidebar com formulário e lista de alunos */}
      <aside className={styles.sidebar}>
        <StudentForm
          onSubmit={editingStudent ? updateStudent : addStudent}
          editingStudent={editingStudent}
        />

        <StudentList
          students={students}
          onSelect={setSelectedStudentId}
          onEdit={setEditingStudent}
          onDelete={deleteStudent}
          selectedId={selectedStudentId}
        />
      </aside>

      {/* área principal que exibe notas do aluno selecionado */}
      <main className={styles.content}>
        {selectedStudent ? (
          <GradesPanel
            student={selectedStudent}
            onAdd={addGrade}
            onUpdate={updateGrade}
            onDelete={deleteGrade}
          />
        ) : (
          <p className={styles.empty}>Selecione um aluno</p>
        )}
      </main>
    </div>
  );
}