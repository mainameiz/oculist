module Oculist
  module Rescuers
    module ConvertError
      extend ActiveSupport::Concern

      included do
        self.rescue_from(Oculist::ConvertError) do |exception|
          render :text => "Cannot convert parameter #{exception.param} to #{exception.type.class_name}", :status => :bad_request
        end
      end
    end
  end
end
