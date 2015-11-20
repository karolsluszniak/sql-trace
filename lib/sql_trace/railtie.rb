module SqlTrace
  class Railtie < Rails::Railtie
    railtie_name :sql_trace

    initializer 'sql_trace.logger' do
      SqlTrace::Logger.start
    end
  end
end
