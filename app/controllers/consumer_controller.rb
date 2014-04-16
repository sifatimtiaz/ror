# Routes consumer website traffic
class ConsumerController < ActionController::Base
  layout "newSections"
  
  # global news query
  $news = News.returnNews
  
  # global banner string
  banners = Banner.find(:all)
  $flash_banners = ""
  for b in banners 
    $flash_banners += b.imagename+","+b.movie_id.to_s+":"
  end
  $flash_banners = $flash_banners[0,($flash_banners.length - 1)]


# faciliate user question emails
require 'net/smtp'
def emailQuestion(question)
  to = "info@lightning-ent.com"
message = <<END_OF_MESSAGE
From: <#{question.email}>
To: {#to}
Subject: Lightning Entertainment User Comment

Name: #{question.fullname != nil ? question.fullname : ""}
Address: #{question.address != nil ? question.address : ""}
City: #{question.city != nil ? question.city : ""}
State: #{question.state != nil ? question.state : ""}
Zip: #{question.zip != nil ? question.zip : ""}
Phone: #{question.phone != nil ? question.phone : ""}
Email: #{question.email != nil ? question.email : ""}
Comments: #{question.comments != nil ? question.comments :  ""}
Submitted: #{question.submitted != nil ? question.submitted : ""}
END_OF_MESSAGE
logger.debug(message)
  # try and catch for local win 
  begin
    # ActionMailer::Base.delivery_method = :smtp
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message message, question.email, to
    end
  rescue
    logger.warn("No mail route for ruby or invalid email addy: " + question.email)
  end
  
end #end email
  
end # end class
