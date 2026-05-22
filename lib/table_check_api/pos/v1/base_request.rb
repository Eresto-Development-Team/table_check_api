# frozen_string_literal: true

module TableCheckApi
  module Pos
    module V1
      class BaseRequest
        def initialize(attributes = {})
          @attributes = attributes ? attributes.dup : {}
          validate_unknown_keys!
          assign_attributes
        end

        def to_h
          self.class::ATTRIBUTES.each_with_object({}) do |attribute, payload|
            value = send(attribute)
            next if value.nil? || (value.respond_to?(:empty?) && value.empty?)

            payload[attribute.to_s] = normalize_payload_value(value)
          end
        end

        private

        attr_reader :attributes

        def fetch(key)
          attributes.fetch(key.to_s, attributes.fetch(key.to_sym, nil))
        end

        def assign_attributes
          self.class::ATTRIBUTES.each do |attribute|
            send("#{attribute}=", fetch(attribute))
          end
        end

        def arrays_as(value, klass)
          Array(value).map { |item| klass.new(item) }
        end

        def normalize_payload_value(value)
          return value.map(&:to_h) if value.is_a?(Array) && value.first.respond_to?(:to_h)

          value
        end

        def validate_unknown_keys!
          return unless defined?(self.class::ATTRIBUTES)

          unknown_keys = attributes.keys.map(&:to_s) - self.class::ATTRIBUTES.map(&:to_s)
          raise ArgumentError, "Unknown attributes: #{unknown_keys.join(', ')}" if unknown_keys.any?
        end
      end
    end
  end
end