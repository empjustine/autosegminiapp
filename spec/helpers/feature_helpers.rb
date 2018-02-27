module FeatureHelpers
  def sign_out
    visit '/users/sign_out'
  end

  def sign_up_with(email, password)
    visit '/users/sign_up'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Create an account'

    expect(page).to have_content 'You have created an account successfully.'
  end

  def sign_in_with(email, password)
    visit '/users/sign_in'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
  end

  def create_task_relation(public=false)
    visit '/task_relations/new'
    if public
      check 'public'
    end

    click_button 'Nova lista de tarefas'
    expect(page).to have_content 'Lista de tarefa salva.'
  end
end
