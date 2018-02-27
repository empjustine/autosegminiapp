feature 'task relations' do
  context 'can be public or private' do
    scenario "hides private task relation" do
      sign_up_with('alice_private@teste.com', '123456')
      create_task_relation()
      visit '/task_relations'
      expect(page).to_not have_content('Você não criou nenhuma lista de tarefa.')
      sign_out()

      sign_up_with('mallory@teste.com', '123456')
      expect(page).to_not have_content('alice_private@teste.com')
    end

    scenario "shows public task relation" do
      sign_up_with('alice_public@teste.com', '123456')
      create_task_relation(public: true)
      visit '/task_relations'
      expect(page).to_not have_content('Você não criou nenhuma lista de tarefa.')
      sign_out()

      sign_up_with('bob@teste.com', '123456')
      expect(page).to have_content('alice_public@teste.com')
    end
  end
end