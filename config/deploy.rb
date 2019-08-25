set :stage, :production
set :branch, 'master'

server '118.27.28.241', user: 'kawayuta', roles: %w{app db web}, port: 22

set :ssh_options, {
    port: 22,
    keys: [File.expand_path('~/.ssh/rsa_tiktok')],
    forward_agent: true,
    password: 'Mirainoyuuta2116!',
    auth_methods: %w(password)
}
