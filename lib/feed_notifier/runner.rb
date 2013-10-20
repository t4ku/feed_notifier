module FeedNotifier
  class Runner
    attr_reader :config

    def initialize(run_config)
      @run_config = run_config
      @config = Config.load(run_config[:config_path])
    end

    def check_pid
      if File.exist?(pid_path)
        pid = File.read(pid_path)
        raise "already running process PID:#{pid}"
      end
    end

    def cleanup
      if File.exist?(pid_path)
        File.delete(pid_path)
      end
    end

    def pid_path
      File.join(@run_config[:pid_dir],'feed_notifier.pid')
    end

    def setup
      if @run_config[:daemon]
        check_pid
        Process.daemon if @run_config[:daemon]
      end

      begin
        yield
      rescue Interrupt => e
        cleanup
      end
    end

    def run
      setup do
        thread = ::Thread.new do
          feed_list = FeedList.new(config)
          while true do
            check_and_notify(feed_list)
            sleep config.interval
          end
        end
        thread.join
      end
    end

    def check_and_notify(feed_list)
      FeedNotifier.logger.info "polling feed list..#{feed_list.urls}"

      entries = feed_list.updated_entries()
      FeedNotifier.logger.info "updated entries #{entries}"
      if entries.size > 0
        entries.each do |entry|
          Notifier.notify(entry)
        end
      end
    end
  end
end
