require 'oculist/rescuers/parameter_missing'
require 'oculist/rescuers/convert_error'

module Oculist
  module Rescuers
    module All
      extend ActiveSupport::Concern

      included do
        self.send :include, Oculist::Rescuers::ParameterMissing
        self.send :include, Oculist::Rescuers::ConvertError
      end
    end
  end
end
