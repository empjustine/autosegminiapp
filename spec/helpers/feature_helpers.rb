module FeatureHelpers
  def sign_out
    click_link 'Finalizar sessão'
    expect(page).to_not have_content('Finalizar sessão')
  end

  def sign_up_with(email, password)
    visit '/users/sign_up'

    fill_in 'E-mail', with: email
    fill_in 'Senha', with: password
    fill_in 'Confirmar senha', with: password
    click_button 'Criar uma conta'

    expect(page).to have_content 'Sua conta foi criada com sucesso.'
  end

=begin
  def sign_in_with(email, password)
    visit '/users/sign_in'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
  end
=end

  def create_task_relation(opts={})
    visit '/task_relations/new'
    if opts[:public]
      check 'public'
    end

    click_button 'Nova lista de tarefas'
    expect(page).to have_content 'Lista de tarefa salva.'
  end
end
