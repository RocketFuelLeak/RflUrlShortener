set :stage, :production
set :rails_env, 'production'

server 'prod.rfl.im', user: 'rails', roles: %w{web app db},
    ssh_options: {
        port: 2553
    }
