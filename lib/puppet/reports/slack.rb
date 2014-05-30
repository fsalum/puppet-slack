require 'puppet'
require 'yaml'
require 'faraday'

Puppet::Reports.register_report(:slack) do

  desc <<-DESC
  Send notification of puppet run reports to Slack Messaging.
  DESC

  @configfile = File.join(File.dirname(Puppet.settings[:config]), "slack.yaml")
  raise(Puppet::ParseError, "Slack report config file #{@configfile} not readable") unless File.exist?(@configfile)
  @config = YAML.load_file(@configfile)
  SLACK_TOKEN = @config[:slack_token]
  SLACK_CHANNEL = @config[:slack_channel]
  SLACK_BOTNAME = @config[:slack_botname]
  SLACK_ICONURL = @config[:slack_iconurl]
  SLACK_URL = @config[:slack_url]

  def process
    if self.status == "failed" or self.status == "changed"
      Puppet.debug "Sending status for #{self.host} to Slack."
      conn = Faraday.new(:url => "#{SLACK_URL}") do |faraday|
          faraday.request  :url_encoded
          faraday.adapter  Faraday.default_adapter
      end

      conn.post do |req|
          req.url "/services/hooks/incoming-webhook?token=#{SLACK_TOKEN}"
          req.body = "{\"channel\":\"#{SLACK_CHANNEL}\",\"username\":\"#{SLACK_BOTNAME}\", \"icon_url\":\"#{SLACK_ICONURL}\",\"text\":\"Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}\"}"
      end
    end
  end
end
