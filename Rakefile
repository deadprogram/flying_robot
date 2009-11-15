require 'rubygems'
require 'hoe'

Hoe.spec 'flying_robot' do
  developer('Ron Evans', 'ron dot evans at gmail dot com')

  self.rubyforge_name = 'deadprogrammer'
end

task :cultivate do
  system "touch Manifest.txt; rake check_manifest | grep -v \"(in \" | patch"
  system "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end