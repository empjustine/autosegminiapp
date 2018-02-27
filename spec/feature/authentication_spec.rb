describe "the account creation feature", :type => :feature do
  it "allows creating an account" do
    visit '/users/sign_up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create an account'

    expect(page).to have_content 'You have created an account successfully.'
  end
end

describe "the signin feature", :type => :feature do
  before :each do
    user = User.new(email: 'user@example.com', password: 'password')
    user.save
  end

  it "let users with a account to sign in" do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
  end
end