module Features
  module SessionHelpers
    def sign_in_as(user)
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Login'
    end

    def sign_out
      visit '/'
      click_link 'Logout'
    end
  end
end