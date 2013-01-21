module Oculist
  class ParameterError < IndexError
    attr_reader :param

    def initialize(param)
      @param = param
    end
  end

  class ParameterMissing < ParameterError
    def initialize(param)
      super(param)
    end
  end

  class ConvertError < ParameterError
    attr_reader :type

    def initialize(param, type)
      super(param)
      @type = type
    end
  end
end
