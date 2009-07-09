Gem::Specification.new do |s|
  s.name = %q{flying_robot}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ron Evans"]
  s.date = %q{2009-07-08}
  s.default_executable = %q{flying_robot}
  s.description = %q{flying_robot takes a standard Ruby Arduino Development (RAD) project, and turns it into a Unmanned Aerial Vehicle (UAV)}
  s.email = ["ron dot evans at gmail dot com"]
  s.executables = ["flying_robot"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "app_generators/flying_robot/USAGE", "app_generators/flying_robot/flying_robot_generator.rb", "app_generators/flying_robot/templates/plugins/Hmc6352_compass.rb", "app_generators/flying_robot/templates/plugins/battery.rb", "app_generators/flying_robot/templates/plugins/flying_robot.rb", "app_generators/flying_robot/templates/plugins/pololu_ir_receiver.rb", "app_generators/flying_robot/templates/plugins/pololu_micro_serial_controller.rb", "app_generators/flying_robot/templates/plugins/pololu_qik_dual_serial_motor_controller.rb", "app_generators/flying_robot/templates/plugins/L293d.rb", "app_generators/flying_robot/templates/plugins/maxsonar.rb", "app_generators/flying_robot/templates/sketch.rb.erb", "bin/flying_robot", "flying_robot.gemspec", "lib/flying_robot.rb", "script/console", "script/destroy", "script/generate", "spec/flying_robot_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake", "test/test_flying_robot_generator.rb", "test/test_generator_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{flying_robot takes a standard Ruby Arduino Development (RAD) project, and turns it into a Unmanned Aerial Vehicle (UAV)}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flying_robot}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{flying_robot takes a standard Ruby Arduino Development (RAD) project, and turns it into a Unmanned Aerial Vehicle (UAV)}
  s.test_files = ["test/test_flying_robot_generator.rb", "test/test_generator_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
