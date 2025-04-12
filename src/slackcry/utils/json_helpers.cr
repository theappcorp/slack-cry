module SlackCry
  module JSONHelpers
    def self.extract_error(parsed : JSON::Any) : String
      parsed["error"]?.try { |e| e.as_s? } || "Unknown error"
    end
  end
end
