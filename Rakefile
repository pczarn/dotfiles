require 'rake'

task :default => :install

desc 'Hook our dotfiles into system-standard positions.'
task :install do
   Dir.glob('*/**{.dot.,.symlink}*') do |linkable|
      dotfile linkable
   end
end

desc 'Unlink dotfiles from system-standard positions.'
task :uninstall do
   Dir.glob('**/*.symlink*').each do |linkable|
      file = linkable.split('/').last.sub('.symlink', '')
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
   sh "git submodule update --init"
end

task :submodule_pull do
   # update submodules
   sh "git submodule -q foreach git pull -q origin master"
end

desc %(Link vim directory)
task :vim => :submodule do
   target = File.join(File.dirname(__FILE__), 'vim')
   vim_dir = "#{ENV['HOME']}/.vim"

   symln target, vim_dir
   symln File.join(target, 'pathogen/autoload'), File.join(target, 'autoload')
end

desc 'Link user settings and packages for Sublime Text 2.'
task :sublime => :submodule do
   packages_dir = "#{ENV['HOME']}/.config/sublime-text-2/Packages"

   user_dir = File.join(packages_dir, 'User')
   if not File.symlink?(user_dir)
      FileUtils.mv user_dir, "#{ user_dir }.backup"
   end

   Dir.glob('sublime2/*') do |package|
      target = File.join(File.dirname(__FILE__), package)
      package_path = File.join(packages_dir, File.basename(package))

      symln target, package_path
   end
end

desc 'Link settings for Xfce 4.'
task :xfce do
   xfce_dir = "#{ENV['HOME']}/.config/xfce4"

   Dir.glob('xfce4/*') do |subdir|
      target = File.join(File.dirname(__FILE__), subdir)
      package_path = File.join(xfce_dir, File.basename(subdir))

      symln target, package_path
   end
end

DOT_EXT = %r{
   \.symlink.* |  # script.symlink.sh => script
   \.dot          # file.dot.txt => file.txt
}x

def dotfile(linkable)
   target = File.join(File.dirname(__FILE__), linkable)
   link_name = "#{ENV["HOME"]}/.#{ File.basename(target).sub(DOT_EXT, '') }"

   symln target, link_name
end

def symln(target, link_name)
   return if File.symlink?(link_name) && File.readlink(link_name) == target

   overwrite = false
   backup = false

   if File.exists?(link_name) || File.symlink?(link_name)
      puts "File already exists: #{link_name}, what do you want to do? [s]kip, [o]verwrite, [b]ackup"
      case STDIN.gets.chomp
      when 'o' then overwrite = true
      when 'b' then backup = true
      end
   
      FileUtils.rm_rf(link_name) if overwrite
      FileUtils.mv(link_name, "#{ link_name }.backup") if backup
   end

   FileUtils.ln_s target, link_name
end
