module SlackCry
  class Config
    property channels : Hash(String, String) = {} of String => String
  end

  @@config = Config.new

  def self.configure(&block : Config ->)
    yield @@config
  end

  def self.config : Config
    @@config
  end
end
