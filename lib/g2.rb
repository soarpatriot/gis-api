class G2

  def self.config
    @instance ||= G2.new
  end

  def self.env
    ENV["G2_ENV"] || "development"
  end

  def root_dir
    @root_dir ||= File.expand_path("../..", __FILE__)
  end

  def app_dir
    @app_dir ||= File.join(root_dir, "app")
  end

  def config_dir
    @config_dir ||= File.join(root_dir, "config")
  end

  def public_dir
    @public_dir ||= File.join(root_dir, "public")
  end

end
