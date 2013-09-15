require 'rake'

desc 'Hook our dotfiles into system-standard positions.'
task :install do
   linkables = Dir.glob('*/**{.symlink}')

   skip_all = false
   overwrite_all = false
   backup_all = false

   linkables.each do |linkable|
      overwrite = false
      backup = false
   
      file = linkable.split('/').last.split('.symlink').first
      target = "#{ENV["HOME"]}/.#{file}"
   
      if File.exists?(target) || File.symlink?(target)
         unless skip_all || overwrite_all || backup_all
            puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
            case STDIN.gets.chomp
            when 'o' then overwrite = true
            when 'b' then backup = true
            when 'O' then overwrite_all = true
            when 'B' then backup_all = true
            when 'S' then skip_all = true
            end
         end
   
         FileUtils.rm_rf(target) if overwrite || overwrite_all
         `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
      end

      `ln -s "$PWD/#{linkable}" "#{target}"`
   end
end

desc 'Unlink dotfiles from system-standard positions.'
task :uninstall do
  Dir.glob('**/*.symlink').each do |linkable|
      file = linkable.split('/').last.split('.symlink').last
      target = "#{ENV["HOME"]}/.#{file}"

      # Remove all symlinks created during installation
      if File.symlink?(target)
        FileUtils.rm(target)
      end

      # Replace any backups made during installation
      if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
        `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"` 
      end
   end
end

task :submodule do
   # init submodules
end

desc 'Link user settings and packages for Sublime Text 2.'
task :sublime => :submodule do
   packages_dir = "#{ENV['HOME']}/.config/sublime-text-2/Packages"

   user_dir = File.join(packages_dir, 'User')
   if not File.symlink?(user_dir)
      FileUtils.mv user_dir, "#{ user_dir }.backup"
   end

   Dir['sublime2/*'].each do |package|
      target = File.join(File.dirname(__FILE__), package)
      package_path = File.join(packages_dir, File.basename(package))

      if not File.symlink?(package_path)
         FileUtils.ln_s target, package_path
      end
   end
end

desc 'Link settings for Xfce 4.'
task :xfce do
   xfce_dir = "#{ENV['HOME']}/.config/xfce4"

   Dir['xfce4/*'].each do |package|
      target = File.join(File.dirname(__FILE__), package)
      package_path = File.join(xfce_dir, File.basename(package))

      if not File.symlink?(package_path)
         if File.exists?(package_path)
            FileUtils.mv package_path, "#{ package_path }.backup"
         end
         FileUtils.ln_s target, package_path
      end
   end
end

task :default => 'install'
