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
          if event.message['text'].include?('OK')
            message = {
              type: 'text',
              text: '確認いたしました'
            }
            client.reply_message(event['replyToken'], message)
          else
            message = {
              type: 'flex',
              altText: 'こんにちは',
              contents: diary_message
            }
            client.reply_message(event['replyToken'], message)
          end
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
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def account_create_message(_event)
    {
      type: 'bubble',
      body: {
        type: 'box',
        layout: 'vertical',
        contents: [
          {
            type: 'text',
            text: 'フレンド登録ありがとうございます😊下記のボタンをクリックしてユーザー登録を完了してください😀',
            wrap: true
          },
          {
            type: 'button',
            action: {
              type: 'uri',
              label: 'こちらです',
              uri: 'https://thread-app-38082.herokuapp.com/finish'
            }
          }
        ]
      }
    }
  end

  def diary_message
    {
      type: 'bubble',
      body: {
        type: 'box',
        layout: 'vertical',
        contents: [
          {
            type: 'text',
            text: 'メッセージありがとうございます。よければ今日の日記を投稿してください☺️',
            wrap: true
          },
          {
            type: 'button',
            action: {
              type: 'uri',
              label: 'こちらです',
              uri: 'https://thread-app-38082.herokuapp.com/diaries'
            }
          }
        ]
      }
    }
  end
end
