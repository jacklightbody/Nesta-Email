BlogFramework.parse;
Class BlogFramework{
	@@EMAIL_HOST='imap.gmail.com'
	@@EMAIL_TYPE='imap'
	@@EMAIL_PORT='995'
	@@EMAIL_USERNAME='emailwritrtest@gmail.com'
	@@EMAIL_PASSWORD='writrtest'
	def parse
		require 'config.rb'
		require 'mail'
		Mail.defaults do
  			retriever_method self.EMAIL_TYPE, :address    => self.EMAIL_HOST,
                          :port       => self.EMAIL_PORT,
                          :user_name  => self.EMAIL_USERNAME,
                          :password   => self.EMAIL_PASSWORD,
                          :enable_ssl => true
		end
		#set up the mail gem... much simpler than php
		emails=Mail.find(:what=>:unread)
		menu="\n"
		emails.each.do |email|
			title=email.subject
			title[' ']='-'
			#remove all spaces from the title
			newpost=File.new('content/pages/'+title+".mdown")
			menu+=title+"/n"
			html="Date: "+email.date.to_s+"/n"+email.body.decoded
			#format the text so nesta likes it
			newpost.puts(html)
		end
		menuf = File.open("menu.txt")
		menuf.puts(menu)
		# add the links to menu.txt
	end
}