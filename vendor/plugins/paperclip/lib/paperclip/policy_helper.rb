require 'multi_json'
class PolicyHelper
    attr_reader :options

    def initialize(_options = {})
      # default max_file_size to 500 MB if nothing is received
      @options = {
        :acl => 'private',#Config.acl,
        :max_file_size => _options[:max_file_size] || Config.max_file_size || 524288000,
        :bucket => Config.bucket_private,
        :file_types => _options[:file_types]
      }.merge(_options).merge(:secret_access_key => Config.secret_access_key)
    end

    # generate the policy document that amazon is expecting.
    def policy_document
      @policy_document ||=
        Base64.encode64(
        MultiJson.dump(
          {
            :expiration => 10.hours.from_now.utc.iso8601(3),
            :conditions => [
              { :bucket => Config.bucket_private },
              { :acl => options[:acl] },
              { :success_action_status => '201' },
              ["content-length-range", 0, options[:max_file_size]],
              #                ["starts-with", "$authenticity_token", ""],
              ["starts-with", "$key", ""],
              #                ["starts-with", "$utf8", ""],
#              ["starts-with", "$Content-Type", ]
            ]
          }
        )
      ).gsub(/\n/, '')
    end

    # sign our request by Base64 encoding the policy document.
    def upload_signature
      @upload_signature ||=
        Base64.encode64(
        OpenSSL::HMAC.digest(
          OpenSSL::Digest::SHA1.new,
          options[:secret_access_key],
          self.policy_document
        )
      ).gsub(/\n/, '')
    end
  end

  module Config
    # this allows us to lazily instan@optionstiate the configuration by reading it in when it needs to be accessed
    class << self
      # if a method is called on the class, attempt to look it up in the config array
      def method_missing(meth, *args, &block)
        if args.empty? && block.nil?
          config[meth.to_s]
        else
          super
        end
      end

      private

      def config

        @config ||= YAML.load(ERB.new(File.read(File.join(::Rails.root, 'config', 'amazon_s3.yml'))).result)[::Rails.env]
      rescue
        warn('WARNING: s3_cors_fileupload gem was unable to locate a configuration file in config/amazon_s3.yml and may not ' +
            'be able to function properly.  Please run `rails generate s3_cors_upload:install` before proceeding.')
        {}
      end
    end
  end