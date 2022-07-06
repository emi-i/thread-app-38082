class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end
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
      end
    end
    head :ok
  end

  private

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
    end
    
    def account_create_message(event)
      {
        type: "bubble",
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: "下記のURLをクリックしてユーザー登録をしてください😀",
              wrap: true
            },
            {
              type: "button",
              action: {
                type: "uri",
                label: "こちらです",
                uri:  "https://thread-app-38082.herokuapp.com/users/sign_up?linkToken=" + event['replyToken']
              }
            }
          ]
        }
      }
    end
end
