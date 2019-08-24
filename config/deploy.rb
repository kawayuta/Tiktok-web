set :stage, :production
set :branch, 'master'

server '	118.27.24.77', user: 'kawayuta', roles: %w{app db web}, port: 22

set :ssh_options, {
    port: 22,
    keys: [File.expand_path('~/.ssh/id_rsa')],
    forward_agent: true,
    auth_methods: %w(publickey)
}
