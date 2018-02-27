feature 'task relations can be public or private' do
  context 'new user experience' do
    scenario "without task relations" do
      sign_up_with('teste@teste.com', '123456')
      expect(page).to have_content('Sign out')

      visit '/task_relations'
      expect(page).to have_content('Você não criou nenhuma lista de tarefa.')
      expect(page).to have_content('Não existem listas de tarefas marcadas como favoritas.')
    end

    scenario "with private task relation" do
      sign_up_with('teste@teste.com', '123456')
      create_task_relation()

      visit '/task_relations'
      expect(page).to_not have_content('Você não criou nenhuma lista de tarefa.')

    end

    scenario "with private task relation" do
      sign_up_with('teste@teste.com', '123456')
      create_task_relation()

      visit '/task_relations'
      expect(page).to_not have_content('Você não criou nenhuma lista de tarefa.')
    end
  end
end