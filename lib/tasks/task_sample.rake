namespace :task_sample do
  desc 'LINE'
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
end
