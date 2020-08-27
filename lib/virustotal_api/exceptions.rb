# frozen_string_literal: true

module VirustotalAPI
  class RateLimitError < RuntimeError
  end

  class Unauthorized < RuntimeError
  end
end
