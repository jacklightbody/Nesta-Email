EMAIL_HOST='pop.gmail.com'
EMAIL_TYPE=:pop3
EMAIL_PORT='995'
EMAIL_USERNAME='emailwritrtest@gmail.com'
EMAIL_PASSWORD='writrtest'
EMAIL_MODE='simple'
require 'mail'
require 'time'
Mail.defaults do
	retriever_method EMAIL_TYPE, {
		:address    => EMAIL_HOST,
       	:port       => EMAIL_PORT,
       	:user_name  => EMAIL_USERNAME,
       	:password   => EMAIL_PASSWORD,
       	:enable_ssl => true
    }
end
# set up the mail gem... much simpler than php
emails=Mail.find(:what=>:unread)
menu=""
emails.each do |email|
	title=email.subject
	title.sub(' ','-')
	# remove all spaces from the title
	newpost=File.new('content/pages/'+title+".mdown","w")
	menu+=title+"\n"
	if(EMAIL_MODE=='simple')
		#they want us to format it
		summary=email.body.decoded.split("/\n/")
		summary=summary.first
		html="Date: "+email.date.to_s+"\nSummary:"+summary+"\n\n"+"#"+email.subject+"\n"+email.body.decoded
		# format the text so nesta likes it
	else
		#they've chosen to do all the formatting on their own. We don't need to help.
		html=email.body.decoded
	end
	newpost.puts(html)
end
menuf = File.open("content/menu.txt", "w+")
menuf.puts(menu)
# add the links to menu.txt