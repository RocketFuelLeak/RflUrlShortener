set :stage, :staging
set :rails_env, 'staging'

server 'staging.rfl.im', user: 'rails', roles: %w{web app db},
    ssh_options: {
        port: 2556
    }
