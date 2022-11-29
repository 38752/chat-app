module SignInSupport
  def sign_in(user)
    # トップページに遷移する
    visit root_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in "user_email", with: user.email # idで指定
    fill_in 'user_password', with: user.password # idで指定
    # ログインボタンをクリックする
    click_on ('Log in') # find('input[name="commit"]').click
    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
  end
end