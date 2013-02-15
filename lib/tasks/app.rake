# http://tech.taskrabbit.com/blog/2013/02/08/rails-app-template-alternative/

namespace :app do
  desc "create a new app with the given name -- for example, app:create[new_app_name]"
  task :create, [:name] => :environment do |t, args|
    underscore = get_underscore(args)
    name = underscore.camelize
    directory = get_directory(args)
    
    raise "#{directory} already exists!" if File.exists?(directory)
    
    puts "Creating app #{name} in #{directory}"
    
    run_command("cp -R #{Rails.root.join("./")} #{directory}")
    run_command("rm -rf `find #{directory} -type d -name .git`")
    run_command("rm -rf `find #{directory} -type f -name .DS_Store`")
    
    # clean up some files
    run_command("rm #{directory}/log/*.log")          # don't need the logs
    run_command("rm #{directory}/lib/tasks/app.rake") # don't need this file
    run_command("rm -rf #{directory}/tmp")            # all gone from tmp
    run_command("mkdir -p #{directory}/tmp/cache/assets")   # new rails app has this one
    
    # change the stuff
    replace_all(directory, "Warren", name)
    replace_all(directory, "warren", underscore)
    
    dir_command(directory, "git init .")
    dir_command(directory, "git add .")
    dir_command(directory, "git commit -a -m 'initial app commit from warren'")
  end
  
  desc "remove the given app"
  task :remove, [:name] => :environment do |t, args|
    directory = get_directory(args)
    run_command("rm -rf #{directory}")
  end
  
  def run_command(cmd)
    cmd = [cmd].flatten
    cmd = cmd.join(" && ")
    puts "Running: #{cmd}"
    `#{cmd}`
  end
  
  def dir_command(directory, cmd)
    cmd = [cmd].flatten
    run_command(["cd #{directory}"] + cmd)
  end
  
  def replace_all(directory, find, replace)
    run_command("grep -rl #{find} #{directory} | xargs sed -i 's/#{find}/#{replace}/g'")
  end
  
  def get_underscore(args)
    args.with_defaults(:name => "")
    underscore = args.name.to_s.underscore
    if underscore.blank?
      raise "No name given -- Use app:create[new_app_name]"
    end
    underscore
  end
  
  def get_directory(args)
    underscore = get_underscore(args)
    Rails.root.join("../#{underscore}")
  end
  
  def rvm_stuff_that_does_not_work
    require 'rvm'
    # setup new gemset
    #run_command("source ~/.rvm/scripts/rvm")
    rvmrc = File.open("#{directory}/.rvmrc", 'rb') { |file| file.read }
    #rvmrc.gsub!("rvm", "~/.rvm/scripts/rvm")
    
    # rvm use ruby-1.9.3-p194@warren --install --create
    
    rvm_ruby = rvmrc[rvmrc.index("ruby")..rvmrc.index("@")-1]
    env = RVM::Environment.new(rvm_ruby)
    puts "Creating gemset #{underscore} in #{rvm_ruby}"
    env.gemset_create(underscore)
    puts "Now using gemset #{underscore}"
    env.gemset_use!(underscore)
    env.use_from_path!(directory)
    
    ENV['BUNDLE_GEMFILE'] = "#{directory}/Gemfile"
    
    puts "Installing bundler gem."
    env.system("gem", "install", "bundler")
    env.system("gem", "install", "rails")
    #puts "Installing other gems."
    #env.system("bundle install")
  end
end
