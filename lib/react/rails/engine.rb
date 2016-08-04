module React
    module Rails
        class Engine < ::Rails::Engine
            initializer 'react_rails.setup_engine', group: :all do |app|
                sprockets_env = app.assets || Sprockets # Sprockets 3.x expects this in a different place
                if Gem::Version.new(Sprockets::VERSION) >= Gem::Version.new('3.7.0')
                    sprockets_env.register_mime_type('application/jsx', extensions: ['.jsx', '.js.jsx', '.es.jsx', '.es6.jsx'])
                    sprockets_env.register_transformer('application/jsx', 'application/javascript', React::JSX::Processor)
                    sprockets_env.register_mime_type('application/jsx+coffee', extensions: ['.jsx.coffee', '.js.jsx.coffee'])
                    sprockets_env.register_transformer('application/jsx+coffee', 'application/jsx', Sprockets::CoffeeScriptProcessor)
                elsif Gem::Version.new(Sprockets::VERSION) >= Gem::Version.new('3.0.0')
                    sprockets_env.register_engine('.jsx', React::JSX::Processor, mime_type: 'application/javascript')
                else
                    sprockets_env.register_engine('.jsx', React::JSX::Template)
                end
            end
        end
    end
end
