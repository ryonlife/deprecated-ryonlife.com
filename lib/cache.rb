# http://navel-labs.com is built in Nesta (a cms on top of Sinatra) and
# hosted by the awesome Heroku.  Since Heroku apps don't have filesystem
# write access, they can't use the default page caching strategy.  But
# Heroku offers awesome http proxy caching if you just set the right headers.
#
# Replace lib/cache.rb with this code and call the cache method like usual
# in Nesta, and boom!  You have page caching on Heroku!
#
# Nesta: http://effectif.com/nesta
# Heroku: http://heroku.com
#
module Sinatra

  module Cache

    VERSION = 'Sinatra::Cache v0.2.0'
    def self.version; VERSION; end


    module Helpers

      # Caches the given URI to a html file in /public
      #
      # <b>Usage:</b>
      #    >> cache haml(:content, ...)
      #
      def cache(content, opts={})
        if options.cache_enabled
          headers 'Cache-Control' => 'public, max-age=300'
        end

        content
      end

      def page_cached_timestamp
        "<!-- page cached: #{Time.now.strftime("%Y-%d-%m %H:%M:%S")} -->\n" if options.cache_enabled
      end

    end #/module Helpers


    # Sets the default options:
    #
    #  * +:cache_enabled+ => toggle for the cache functionality. Default is: +true+
    #
    def self.registered(app)
      app.helpers(Cache::Helpers)
      app.set :cache_enabled, true
    end

  end #/module Cache

  register(Sinatra::Cache)

end #/module Sinatra