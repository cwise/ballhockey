class SendGridUtility
  def self.get_unsubscribes
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.suppression.unsubscribes.get
    JSON.parse(response.body)
  end

  def self.clear_unsubscribe email
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.suppression.unsubscribes._(email).delete
  end
end