class Contact < MailForm::Base
  
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :subject,   :validate => true
  attribute :message,   :validate => true
  #hidden check against computer generated messages and spam
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "MyMoneyOnTheGo Message - #{subject}",
      # :to => "your_email@example.org",
      :to => ENV['CONTACT_FORM_EMAIL'],
      :from => %("#{name}" <#{email}>)
    }
  end
end