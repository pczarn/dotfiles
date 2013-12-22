require 'rake'

task :default => [:install, :vim]

desc %(Hook our dotfiles into home directory)
task :install => :sources do
   dotfiles
end

desc %(Unlink dotfiles from home directory)
task :uninstall do
   dotfiles do |_, link_path|
      link_name = File.basename(link_path)

      # Remove all symlinks created during installation
      if File.symlink?(link_path)
        FileUtils.rm(link_path)
      end

      # Replace any backups made during installation
      backup = "#{ link_path }.backup"
      if File.exists?(backup)
         FileUtils.mv(backup, link_path)
      end
   end
end

task :sources do
   sources = Dir[File.join(File.dirname(__FILE__), '*/**.source.sh*')]
   sources_dir = File.join(ENV["HOME"], '.sources')

   FileUtils.mkdir_p sources_dir
   symln sources, sources_dir
end

desc %(Init submodules)
task :submodule do
   sh "git submodule update --init"
end

desc %(Update all submodules)
task :pull do
   sh "git submodule -q foreach git pull -q origin master"
end

desc %(Link vim directory)
task :vim => :submodule do
   target  = File.join(File.dirname(__FILE__), 'vim')
   vim_dir = File.join(ENV['HOME'], '.vim')

   symln target, vim_dir
end

desc %(Link user settings and packages for Sublime Text 2)
task :sublime => :submodule do
   targets = Dir[File.join(File.dirname(__FILE__), 'sublime2/*')]
   packages_dir = File.join(ENV['HOME'], ".config/sublime-text-2/Packages")

   symln targets, packages_dir
end

desc %(Link settings for Xfce 4)
task :xfce do
   # use ln -s xfce4/* ~/.config/xfce4
   targets = Dir[File.join(File.dirname(__FILE__), 'xfce4/*')]
   xfce_dir = File.join(ENV['HOME'], "/.config/xfce4")

   symln targets, xfce_dir
end

desc %(Build Arch Linux image)
task :archiso do
   cd "archlive"
   sh "sudo ./build.sh -v"
end

DOT_EXT = %r{
   \.symlink.* |  # script.symlink.sh => script
   \.dot          # file.dot.txt => file.txt
}x

def dotfiles(path="*/**{.dot.,.symlink}*")
   Dir.glob(path) do |dotfile|
      link_target = File.join(File.dirname(__FILE__), dotfile)
      link_path = "#{ENV["HOME"]}/.#{ File.basename(dotfile).sub(DOT_EXT, '') }"

      if block_given?
         yield link_target, link_path
      else
         symln link_target, link_path
      end
   end
end

def symln(link_target, path)
   if link_target.kind_of?(Array)
      FileUtils.ln_s(
         link_target.reject {|target|
            interactive(target, File.join(path, File.basename(target)))
         },
         path
      )
   else
      interactive(link_target, path)
      FileUtils.ln_s(link_target, path) if not File.exists?(path)
   end
end

def interactive(link_target, path)
   overwrite = false
   backup = false
   link_name = File.basename(path)

   if File.symlink?(path)
      return true if File.readlink(path) == link_target
      puts "Link already exists: #{link_name} => #{File.readlink(path)}. [s]kip, [o]verwrite"
      if STDIN.gets.chomp == 'o'
         FileUtils.rm_rf(path)
      end
   elsif File.exists?(path)
      puts "File already exists: #{link_name}. [s]kip, [o]verwrite, [b]ackup"
      case STDIN.gets.chomp
      when 'o' then overwrite = true
      when 'b' then backup = true
      end
   
      FileUtils.rm_rf(path) if overwrite
      FileUtils.mv(path, "#{ path }.backup") if backup
   end
end
