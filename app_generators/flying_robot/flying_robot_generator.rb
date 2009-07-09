class FlyingRobotGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil

  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      # create stub
      m.template 'sketch.rb.erb'   , "#{base_name}.rb"
      
      # copy plugins
      m.file     "plugins/battery.rb",                                  "vendor/plugins/battery.rb"
      m.file     "plugins/flying_robot.rb",                             "vendor/plugins/flying_robot.rb"
      m.file     "plugins/Hmc6352_compass.rb",                          "vendor/plugins/Hmc6352_compass.rb"
      m.file     "plugins/pololu_ir_receiver.rb",                       "vendor/plugins/pololu_ir_receiver.rb"
      m.file     "plugins/pololu_micro_serial_controller.rb",           "vendor/plugins/pololu_micro_serial_controller.rb"
      m.file     "plugins/pololu_qik_dual_serial_motor_controller.rb",  "vendor/plugins/pololu_qik_dual_serial_motor_controller.rb"
      m.file     "plugins/L293d.rb",                                    "vendor/plugins/L293d.rb"
      m.file     "plugins/maxsonar.rb",                                 "vendor/plugins/maxsonar.rb"
      
      m.dependency "install_rubigen_scripts", [destination_root, 'flying_robot'],
        :shebang => options[:shebang], :collision => :force
    end
  end

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |o| options[:author] = o }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      vendor/plugins
      examples
    )
end