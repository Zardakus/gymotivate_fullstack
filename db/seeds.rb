# Limpa os dados antigos para não duplicar toda vez que rodarmos o seed
puts "Limpando o banco de dados..."
Workout.destroy_all
User.destroy_all
Gym.destroy_all

puts "Criando Academias..."
gym_iron = Gym.create!(name: "Academia Iron Fist", active: true)
gym_smart = Gym.create!(name: "Academia Smart Fit", active: true)

puts "Criando Usuários para a Academia Iron..."
# Criamos um Admin, um Professor e dois Alunos na Iron Fist
admin_iron = User.create!(
  email: "admin.iron@gym.com",
  password: "password123",
  name: "Carlos Admin Iron",
  role: :admin,
  gym: gym_iron
)

professor_iron = User.create!(
  email: "professor.iron@gym.com",
  password: "password123",
  name: "Rodrigo Treinador",
  role: :trainer,
  gym: gym_iron
)

aluno_iron1 = User.create!(email: "aluno1.iron@gym.com", password: "password123", name: "Pedro Aluno", role: :member, gym: gym_iron)
aluno_iron2 = User.create!(email: "aluno2.iron@gym.com", password: "password123", name: "Lucas Aluno", role: :member, gym: gym_iron)


puts "Criando Usuários para a Academia Smart..."
# Criamos um Professor e um Aluno na Smart Fit
professor_smart = User.create!(
  email: "professor.smart@gym.com",
  password: "password123",
  name: "Claudia Treinadora",
  role: :trainer,
  gym: gym_smart
)

aluno_smart = User.create!(email: "aluno.smart@gym.com", password: "password123", name: "Mariana Aluna", role: :member, gym: gym_smart)


puts "Criando Fichas de Treino da Academia Iron..."
Workout.create!(
  title: "Treino de Hipertrofia - A",
  description: "Supino Reto 4x10, Desenvolvimento 3x12",
  trainer: professor_iron,
  member: aluno_iron1,
  gym: gym_iron
)

Workout.create!(
  title: "Treino de Definição - B",
  description: "Agachamento Livre 4x12, Leg Press 3x15",
  trainer: professor_iron,
  member: aluno_iron2,
  gym: gym_iron
)


puts "Criando Fichas de Treino da Academia Smart..."
Workout.create!(
  title: "Treino Funcional Smart",
  description: "Corrida na Esteira 20min, Abdominais 4x30",
  trainer: professor_smart,
  member: aluno_smart,
  gym: gym_smart
)

puts "Banco de dados populado com sucesso!"
