# http://tech.taskrabbit.com/blog/2013/02/08/rails-app-template-alternative/

namespace :app do
  desc "create a new app with the given name -- for example, app:create[new_app_name]"
  task :create, [:name] => :environment do |t, args|
    underscore = get_underscore(args)
    name = underscore.camelize
    directory = get_directory(args)
    original_name = Rails.application.class.parent_name
    
    raise "#{directory} already exists!" if File.exists?(directory)
    
    puts "Creating app #{name} in #{directory}"
    
    run_command("git clone #{Rails.root} #{directory}")
    run_command("git remote add #{underscore} #{directory} || git remote set-url #{underscore} #{directory}")
    
    # remove tracking with original branch
    dir_command(directory, "git remote rm origin")
    
    # add the original remote to later pull changes made on the base app
    dir_command(directory, "git remote add #{original_name.underscore} #{Rails.root}")
    
    # change the stuff
    replace_all(directory, Rails.application.class.parent_name, name)
    replace_all(directory, Rails.application.class.parent_name.underscore, underscore)
    
    dir_command(directory, "git add .")
    dir_command(directory, "git commit -a -m 'renamed app to #{name}'")
    
    dir_command(directory, "rake secret:replace")
    dir_command(directory, "git add .")
    dir_command(directory, "git commit -a -m 'regenerated secret token'")

    # copy .bundle if exists (see http://hmarr.com/2012/nov/08/rubies-and-bundles/)
    if Rails.root.join(".bundle").exist?
      run_command("cp -rl .bundle #{directory}/")
    end
    
    dir_command(directory, "bundle")
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
