class Picture < ActiveRecord::Base
	has_attached_file :image, styles: { large: "400x400" }

  belongs_to :user
  belongs_to :house

<<<<<<< HEAD
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"]}

  # def self.enroll(url)

  #   person = 'gisele'
  #   house = 'vsangeltest'
  #   url1 = url

  #   body = {:image => url1, :subject_id => person, :gallery_name => house, :selector => "SETPOSE", :symmetricFill => "true"  }
  #   body = body

  #   headers = {
  #     :content_type => 'application/json',
  #     :app_id => ENV['KAIROS_ID'],
  #     :app_key => ENV['KAIROS_KEY']
  #   }

  #   response = HTTParty.post('https://api.kairos.com/enroll', { headers: headers, body: body })
  #   ap response
  # end

  # def self.recognize(url)

  #   house = 'vsangeltest'
  #   lookup = url
  #   threshold = '0.80'

  #   body = {:image => lookup, :gallery_name => house, :threshold => threshold}
  #   body = body.to_json


  #   headers = {
  #     :content_type => 'application/json',
  #     :app_id => ENV['KAIROS_ID'],
  #     :app_key => ENV['KAIROS_KEY']
  #   }

  #   response = HTTParty.post('https://api.kairos.com/recognize', { body: body, headers: headers})

  #   response_short = response.parsed_response

  #   successtest = response_short['images'][0]['transaction']['status']
  #   p successtest
  #   successtest
  # end
=======
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
    ap response
  end

  def self.recognize(url, house_name, number)

    threshold = '0.80'

    body = {:image => url, :gallery_name => house_name, :threshold => threshold}
    body = body.to_json


    headers = {
      'content_type' => 'application/json',
      'app_id' => ENV['KAIROS_ID'],
      'app_key' => ENV['KAIROS_KEY']
    }

    response = HTTParty.post('https://api.kairos.com/recognize', { body: body, headers: headers})

    ap response

    successtest = response['images'][0]['transaction']['status']
    # ap successtest
    successtest
    Picture.text(successtest, number)
  end

  def self.text(status, number)
    client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
    from = '+19546136144'
    if status == 'success'
      client.account.messages.create(
        :from => from,
        :to => "+13053354270",
        :body => 'Face Matched'
        )
    else
      client.account.messages.create(
        :from => from,
        :to => "+13053354270",
        :body => "Face Didn't Match"
        )
    end
  end
>>>>>>> 7eef255614a339e4d73edd8d9c60f426e9da9e70
end
