EMAIL_HOST='pop.gmail.com'
EMAIL_TYPE=:pop3
EMAIL_PORT='995'
EMAIL_USERNAME='emailwritrtest@gmail.com'
EMAIL_PASSWORD='writrtest'
EMAIL_MODE='simple'
require 'mail'
require 'time'
require 'psych'
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
yaml=Psych.load(File.open("config/config.yml"))
content=yaml['content']
# get what they're using for content
emails.each do |email|
	title=email.subject
	title.sub(' ','-')
	# remove all spaces from the title
	i=0
	while(File.exists?(content+'/pages/'+title+".mdown"))
		title=title+"-"+i
		i=i+1
		# check if this file still exists 
	end
	newpost=File.new(content+'/pages/'+title+".mdown","w")
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
if(File.exists?(content+"/menu.txt"))
	menuf = File.open(content+"/menu.txt", "w+")
else
	menuf=File.new(content+'/menu.txt',"w")
	#if the menu file isn't there then create it
end
menuf.puts(menu)
# add the links to menu.txt