module FeedNotifier
  def self.configure
    config = Config.new 
    yield config
    config
  end

  class Config
    attr_accessor :feed_urls
    attr_accessor :interval

    class <<self
      def load(config_path)
        eval(File.read(config_path),binding)
      rescue RuntimeError => e
        FeedNotifier.logger.error "error loading config file #{e.message}"
      end
    end

    def initialize(attrs={})
      @feed_urls = []
      @interval  = 60*2
    end

    def log_path
      STDOUT
    end

  end
end
