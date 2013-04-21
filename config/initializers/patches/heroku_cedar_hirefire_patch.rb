require 'heroku-api'
module HireFire
  module Environment
    class Heroku < Base
      def environment
        @environment ||= HireFire::Environment.const_get(
          if environment = HireFire.configuration.environment
            environment.to_s.camelize
          else
            ::Rails.env.production? ? 'Heroku' : 'Noop'
          end
        ).new
      end
            
      def hirefire_hire
        if Resque.working == [] && Resque.info[:pending] > 1
          Resque.workers.each do |w| w.unregister_worker end
          environment.hire
        end
      end

      private

      ##
      # Either retrieves the amount of currently running workers,
      # or set the amount of workers to a specific amount by providing a value
      #
      # @overload workers(amount = nil)
      #   @param [Fixnum] amount will tell heroku to run N workers
      #   @return [nil]
      # @overload workers(amount = nil)
      #   @param [nil] amount
      #   @return [Fixnum] will request the amount of currently running workers from Heroku
      def workers(amount = nil)

        #
        # Returns the amount of Delayed Job
        # workers that are currently running on Heroku
        if amount.nil?
          return heroku.get_ps(ENV['APP_NAME']).body.select {|p| p['process'] =~ /worker.[0-9]+/}.length
        end

        ##
        # Sets the amount of Delayed Job
        # workers that need to be running on Heroku
        return heroku.post_ps_scale(ENV['APP_NAME'], "worker", amount)

      rescue ::Heroku::API::Errors::Error
        HireFire::Logger.message("Worker query request failed with #{ $!.class.name } #{ $!.message }")
        nil
      end

      ##
      # Get the heroku connection. Needs to have the HEROKU_API_KEY in the environment
      def heroku(api_key = nil)
        @heroku ||= ::Heroku::API.new(:api_key => api_key || ENV['HEROKU_API_KEY'])
      end

    end
  end
end