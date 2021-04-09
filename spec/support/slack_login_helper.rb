module SlackLoginHelper
  def slack_login_first_time
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # Devise使用時に必要な記載
    Rails.application.env_config["omniauth.auth"] = set_slack_omniauth # omniauth.authの値を代入
    allow_any_instance_of(ApplicationController).to receive(:get_user_info).and_return(set_user_info) # strategy.authの値を代入
    visit root_path
    click_on 'Slackログイン'
    expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
  end

  def create_profile
    expect(current_path).to eq(new_profile_path), 'パスがnew_profile_pathではありません'
    profile = create(:profile)
    fill_in 'profile_height',	with: profile.height
    select profile.blood_type, from: 'profile_blood_type'
    select profile.prefecture.name, from: 'profile_prefecture_id'
    select '男性', from: 'profile_gender'
    fill_in 'profile_birthday',	with: profile.birthday
    fill_in 'profile_day_of_joinning',	with: profile.day_of_joinning
    expect{ click_on '入力完了！' }.to change(Profile, :count).by(1), 'プロフィール数が1つ増えていません'
  end

  def slack_login_till_access_profiles_path
    slack_login_first_time
    create_profile
    click_button 'プロフィール閲覧'
    expect(current_path).to eq(profiles_path), 'パスがprofiles_pathではありません'
  end
end