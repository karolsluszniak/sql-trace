module SqlTrace
  class Logger
    class << self
      def start
        if (sql_trace = ENV['SQL_TRACE'].to_i) > 0
          stack_size = sql_trace > 1 ? sql_trace : 5
          stack_root = Rails.root.to_s
          min_duration = ENV['SQL_TRACE_MIN_DURATION'].to_i

          match = if (raw_match = ENV['SQL_TRACE_MATCH']).present?
            raw_match.match(/^\/.*\/$/) ? Regexp.compile(raw_match[1..-2]) : Regexp.quote(raw_match)
          end

          if color = ENV['SQL_TRACE_COLOR']
            require 'colorize'
          end

          ActiveSupport::Notifications.subscribe("sql.active_record") do |n, s, e, i, payload|
            name = payload[:name]
            sql = payload[:sql]
            duration = ActiveSupport::Notifications::Event.new(n, s, e, i, payload).duration

            unless name.in?(%w{CACHE SCHEMA}) ||
                (min_duration > 0 && duration < min_duration) ||
                (match && !sql.match(match))
              stack = caller.select do |line|
                line.start_with?(stack_root)
              end[0..stack_size - 1].map do |line|
                line.sub("#{stack_root}/", '')
              end

              if stack.present?
                stack.each do |line|
                  line = "  #{line}"
                  line = line.send(color) if color

                  puts line
                end && puts
              end
            end
          end
        end
      end
    end
  end
end
