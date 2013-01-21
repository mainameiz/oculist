module Oculist
  module StringUtils
    TRUE_VALUES = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES
    FALSE_VALUES = ActiveRecord::ConnectionAdapters::Column::FALSE_VALUES

    def self.boolean?(value)
      true?(value) || false?(value)
    end

    def self.true?(value)
      value.is_a?(TrueClass) || TRUE_VALUES.include?(value)
    end

    def self.false?(value)
      value.is_a?(FalseClass) || FALSE_VALUES.include?(value)
    end

    def self.to_bool(value)
      return true if true?(value)
      return false if false?(value)
      return nil
    end
  end
end
