Gem::Specification.new do |s|
  s.name = %q{flying_robot}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ron Evans"]
  s.date = %q{2009-04-03}
  s.default_executable = %q{flying_robot}
  s.description = %q{flying_robot takes a standard Ruby Arduino Development (RAD) project, and turns it into a Unmanned Aerial Vehicle (UAV)}
  s.email = ["ron dot evans at gmail dot com"]
  s.executables = ["flying_robot"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = [".git/COMMIT_EDITMSG", ".git/HEAD", ".git/config", ".git/description", ".git/hooks/applypatch-msg", ".git/hooks/commit-msg", ".git/hooks/post-commit", ".git/hooks/post-receive", ".git/hooks/post-update", ".git/hooks/pre-applypatch", ".git/hooks/pre-commit", ".git/hooks/pre-rebase", ".git/hooks/prepare-commit-msg", ".git/hooks/update", ".git/index", ".git/info/exclude", ".git/logs/HEAD", ".git/logs/refs/heads/master", ".git/logs/refs/remotes/origin/master", ".git/objects/00/b5adf658d17152004a36817ba947aedf491039", ".git/objects/01/d96a7e5c0a09a41d0dda1cbb961b236a2564a8", ".git/objects/02/9399c910756675b3b84abff52cc640950b07e7", ".git/objects/07/42df6a3e3ef2323403737cb29415ab595c9eec", ".git/objects/0a/884092fcc606725fb52f236048bb412251cd58", ".git/objects/0c/0a87e27237d46874f3b54922413a5aa80fac0c", ".git/objects/0c/6117d9fb83be5d944c757c10508e44b4cf2b30", ".git/objects/11/9256a99d682474369cf022c25cedc97485ed80", ".git/objects/16/2274ed393ae601783715ed9ee0546f0e49e192", ".git/objects/17/822be62d009f24ac22b68c41bc303e81aa748c", ".git/objects/24/15fa49cb1d3d84a29d0fa0c7ac098cb759977a", ".git/objects/28/8ff74fe96d2356582ea231132ce5964e3bbb77", ".git/objects/33/babe4f994a987bcb89a1ce7a7777bb998616e1", ".git/objects/38/76be26294bea9ec5f1615d229a46cd52396174", ".git/objects/3b/55b773b5634646cb5cc7216cfc37324b2d7fd1", ".git/objects/3f/3a59677970e814c64219642ef7fd9e4a8d2f79", ".git/objects/40/2c6ce037570dd207d0fbaa73a082d8024f836c", ".git/objects/5b/3e67df659a0c8c4962fa2733d9556395caf5be", ".git/objects/61/ae3fcb5de65e2bc7c1f6b9fdb25515f6b2b86f", ".git/objects/64/66f58bbfb297b6a43c5347e9196068d6df265b", ".git/objects/6f/cb8f1c6f6145a3fefbd82c846eeb8981ab5ae9", ".git/objects/73/29079427322d450baa67ed4dafb2f27929deb8", ".git/objects/7e/e930df22100b3e809ae68304e7c9aa18ef5e29", ".git/objects/7f/3bbdb5c2c047c9e4b3477b6d9b592fd408f650", ".git/objects/85/b8f4365b092a2b4c52deb085a6154646c859c2", ".git/objects/8a/2172d45c5aee76a12b324dd045c28881760430", ".git/objects/8e/0379eb6a848f8834afecd9d7eef40f76a1fa79", ".git/objects/94/5a9e05c5e92043533a822de956b7ee393c8cc4", ".git/objects/96/036ef0a94c94474246bb7c97f8544fe6631789", ".git/objects/97/7deb3a51c81000f8cd695dd112b9d07f91e740", ".git/objects/9c/aaf5e77e0e063f01e3f67191e35ad1dcf1ec72", ".git/objects/9d/9debfc0e9e856eb1791accb9cc5b3efad633c5", ".git/objects/a5/2055a59d0d28cb88c2e41c92753aa73ff67b3b", ".git/objects/b0/0fd062ca14bbdf62db41a4beba3440625ded7f", ".git/objects/b2/8603613d6369d48142899ecda6cf57059fa05b", ".git/objects/ba/126cdc7ddfe07556c1c6f7a5e25ddb0ba24467", ".git/objects/c2/7f6559350f7adb19d43742b55b2f91d07b6550", ".git/objects/cb/bbac470ae0ef8cba531f79354ddfbe8152dc0c", ".git/objects/cf/6add7ea568d3d90d6a1f8afb0898b0119b14ff", ".git/objects/e0/ec53720a14ed85a6f695631122ac0f3944a6df", ".git/objects/e4/1b5fa0c54b624c302af644b11fa55e38318515", ".git/objects/e4/8464df56bf487e96e21ea99487330266dae3c9", ".git/objects/e8/6810a8b4d7a9422a8a1b79769bd877ba0b3d71", ".git/objects/eb/d3e62e33707d7429f3f800499d51def2436f94", ".git/objects/ef/7d99e44e55dd88adbc0520c58a1a35771162bd", ".git/objects/f5/b8ca349ce42ac655e4e5ad647b199219ddead2", ".git/refs/heads/master", ".git/refs/remotes/origin/master", ".gitignore", "History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "app_generators/flying_robot/USAGE", "app_generators/flying_robot/flying_robot_generator.rb", "app_generators/flying_robot/templates/plugins/Hmc6352_compass.rb", "app_generators/flying_robot/templates/plugins/battery.rb", "app_generators/flying_robot/templates/plugins/flying_robot.rb", "app_generators/flying_robot/templates/plugins/pololu_ir_receiver.rb", "app_generators/flying_robot/templates/plugins/pololu_micro_serial_controller.rb", "app_generators/flying_robot/templates/plugins/pololu_qik_dual_serial_motor_controller.rb", "app_generators/flying_robot/templates/sketch.rb.erb", "bin/flying_robot", "flying_robot.gemspec", "lib/flying_robot.rb", "script/console", "script/destroy", "script/generate", "spec/flying_robot_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake", "test/test_flying_robot_generator.rb", "test/test_generator_helper.rb"]
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
