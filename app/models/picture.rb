class Picture < ActiveRecord::Base
	has_attached_file :image, styles: { large: "400x400" }

  belongs_to :user
  belongs_to :house

  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/png"]}

  def self.enroll(url, person, house_name)


    body = {:image => url, :subject_id => person, :gallery_name => house_name, :selector => "SETPOSE", :symmetricFill => "true"  }
    body = body.to_json

    headers = {
      'content_type' => 'application/json',
      'app_id' => ENV['KAIROS_ID'],
      'app_key' => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/enroll', { headers: headers, body: body })
    # ap response
  end

  def self.recognize(url, house_name)

    threshold = '0.80'

    body = {:image => url, :gallery_name => house_name, :threshold => threshold}
    body = body.to_json


    headers = {
      'content_type' => 'application/json',
      'app_id' => ENV['KAIROS_ID'],
      'app_key' => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/recognize', { body: body, headers: headers})

    # ap response

    successtest = response['images'][0]['transaction']['status']
    # ap successtest
    successtest
    Picture.text(successtest)
  end

  def self.text(status)
    client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
    from = '+19546136144'
    if status == 'success'
      client.account.messages.create(
        :from => from,
        :to => "+13053354270",
        :body => 'Face Matched'
        )
		elsif status == 'lock'
			client.account.messages.create(
        :from => from,
        :to => "+13053354270",
        :body => 'House Locked'
        )
    else
      client.account.messages.create(
        :from => from,
        :to => "+13053354270",
        :body => "Face Didn't Match"
        )
    end
  end
end
