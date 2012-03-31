
	EMAIL_HOST='pop.gmail.com'
	EMAIL_TYPE=:pop3
	EMAIL_PORT='995'
	EMAIL_USERNAME='emailwritrtest@gmail.com'
	EMAIL_PASSWORD='writrtest'
		require 'mail'
		Mail.defaults do
  			retriever_method EMAIL_TYPE, {
  			:address    => EMAIL_HOST,
            :port       => EMAIL_PORT,
            :user_name  => EMAIL_USERNAME,
            :password   => EMAIL_PASSWORD,
            :enable_ssl => true
        	}
		end
		#set up the mail gem... much simpler than php
		emails=Mail.find(:what=>:unread)
		puts YAML::dump(emails)
		menu="\n"
		emails.each do |email|
			title=email.subject
			title.sub(' ','-')
			#remove all spaces from the title
			newpost=File.new('content/pages/'+title+".mdown")
			menu+=title+"/n"
			html="Date: "+email.date.to_s+"/n"+email.body.decoded
			#format the text so nesta likes it
			newpost.puts(html)
		end
		menuf = File.open("content/menu.txt", "w+")
		menuf.puts(menu)
		# add the links to menu.txt