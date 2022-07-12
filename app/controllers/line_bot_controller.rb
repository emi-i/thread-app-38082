class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'flex',
            altText: '初めまして',
            contents: account_create_message(event)
          }
          client.reply_message(event['replyToken'], message)
        end
      end
      case event
      when Line::Bot::Event::Follow
        message = {
          type: 'flex',
          altText: '初めまして',
          contents: account_create_message(event)
        }
        client.reply_message(event['replyToken'], message)

        userId = event['source']['userId'] 
        Lineuser.find_or_create_by(uid: userId)
      end
      case event
      when Line::Bot::Event::Unfollow
        userId = event['source']['userId']  
        user = Lineuser.find_by(uid: userId)
        user.destroy if user.present?
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def account_create_message(event)
    {
      type: 'bubble',
      body: {
        type: 'box',
        layout: 'vertical',
        contents: [
          {
            type: 'text',
            text: '下記のURLをクリックしてユーザー登録をしてください😀',
            wrap: true
          },
          {
            type: 'button',
            action: {
              type: 'uri',
              label: 'こちらです',
              uri: 'https://thread-app-38082.herokuapp.com/users/sign_up?linkToken=' + event['replyToken']
            }
          }
        ]
      }
    }
  end
end
