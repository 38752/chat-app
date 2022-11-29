require 'rails_helper'

RSpec.describe 'チャットルームの削除機能', type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されている' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message, 5, room_id: @room_user.room_id)
    message = FactoryBot.create(:message)

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect {
      find_link('チャットを終了する',  href: room_path(@room_user.room)).click
    }.to change { Message.count }.by(-5)

    # トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)

    # ルームリストに削除したチャットルームが存在しないことを確認する
    expect(page).to have_no_content(@room_user.room.name)

  end
end