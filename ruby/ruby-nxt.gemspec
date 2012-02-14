Gem::Specification.new do |s|
  s.name      = 'ruby-nxt'
  s.version   =  "0.1.1"
  s.author    = "Tony Buser"
  s.email     = "gr0k@rubyforge.org"
  s.homepage  = "http://ruby-nxt.rubyforge.org"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "LEGO Mindstorms NXT library"
  s.description = "Provides a Ruby interface to LEGO Mindstorms NXT"
  s.files     = Dir.glob("{test,examples,lib,doc}/**/*").delete_if {|item| item.include?(".svn") }
  s.require_path  = "lib"
  s.has_rdoc      = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.rdoc_options << "--main" << 'README' << "--title" << "'ruby-nxt RDoc'" << "--line-numbers"
  s.rubyforge_project = "ruby-nxt"
end
