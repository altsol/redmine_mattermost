require 'httpclient'

module RedmineAmazonChime
	class ChimeMessage
		def initialize(context, chime_webhook)
			@context = context
			@chime_webhook = chime_webhook
			@payload = {"Content": IssueMessageBuilder.new(context).build()}.to_json
		end

		def send()
			if not @payload.empty?
				client = HTTPClient.new()
				client.ssl_config.cert_store.set_default_paths()
				client.ssl_config.ssl_version = :auto

				begin
					client.post_async(@chime_webhook, @payload, 'Content-Type' => 'application/json')
				rescue Exception => e
					Rails.logger.error("Cannot connect to #{@chime_webhook}")
					Rails.logger.error(e)
				end
			end
		end
	end
end