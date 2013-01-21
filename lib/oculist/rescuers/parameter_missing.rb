module Oculist
  module Rescuers
    module ParameterMissing
      extend ActiveSupport::Concern

      included do
        self.rescue_from(Oculist::ParameterMissing) do |exception|
          render :text => "Required parameter missing: #{exception.param}", :status => :bad_request
        end
      end
    end
  end
end
