namespace :scheduler do
  desc 'This task is called by the Heroku scheduler add-on'
  task push_line_message: :environment do
    message = {
      type: 'flex',
      altText: 'こんにちは',
      contents: how_message
    }

    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end

    SnsCredential.all.each do |user|
      response = client.push_message(user.uid, message)
    end
  end

  def how_message
    {
      type: 'bubble',
      footer: {
        type: 'box',
        layout: 'vertical',
        spacing: 'sm',
        contents: [
          {
            type: 'text',
            text: 'お元気ですか？'
          },
          {
            type: 'button',
            action: {
              type: 'message',
              label: 'OK',
              text: 'OK'
            }
          }
        ],
        flex: 0
      }
    }
  end

  desc 'This task is called by the Heroku scheduler add-on'
  task safety_confirmation: :environment do
    require 'date'
    # 前日のEmergencyList削除
    EmergencyList.destroy_all


    users = SnsCredential.all.includes(:user)
    emergencies = []
    emergencies_contact = {}
    emergency_list = []

    # 二日以上連絡のないuser
    users.each do |user|
      today = Date.today
      emergencies << user if user.safe_date == Date.today - 2
    end

    # 二日以上連絡のないuserの情報
    emergencies.each do |emergency|
      name = emergency.user.name
      tel = emergency.user.address.tel
      emergency_tel = emergency.user.address.emergency_contact_tel
      emergencies_contact[:name] = name
      emergencies_contact[:tel] = tel
      emergencies_contact[:emergency_tel] = emergency_tel
      emergency_list << emergencies_contact
    end

    # EmergencyListに追加
    emergency_list.each do |emergency|
      user = EmergencyList.new
      user.name = emergency[:name]
      user.tel = emergency[:tel]
      user.emergency_tel = emergency[:emergency_tel]
      user.save
    end
  end
end
