# frozen_string_literal: true

require 'json'

module TableCheckApi
  module Pos
    module V1
      class BaseResponse
        def self.from_response(response)
          new(response)
        end

        def initialize(response)
          raw_body = response.respond_to?(:body) ? response.body : response
          @body = parse_body(raw_body)
        end

        def raw
          @body
        end

        alias body raw

        def errors
          @body['errors'] || []
        end

        def success?
          errors.empty?
        end

        private

        def parse_body(raw_body)
          JSON.parse(raw_body.to_s)
        rescue JSON::ParserError
          {}
        end
      end
    end
  end
end