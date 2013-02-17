task :create_admin => :environment do
  login = "admin@example.com"
  password = "password"
  user = User.create! :email => login, :password => password
  user.add_role :admin
  puts [login, password].join(" / ")
end
