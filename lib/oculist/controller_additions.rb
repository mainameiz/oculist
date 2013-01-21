require 'oculist/utils'
require 'oculist/errors'

module Oculist
  module ControllerAdditions

    module Boolean; end

    def requires(names, opts = {})
      if names.is_a?(Array)
        names.each do |name|
          requires(name, opts)
        end
      else
        opt(names, true, opts)
      end
    end

    def permits(names, opts = {})
      if names.is_a?(Array)
        names.each do |name|
          permits(name, opts)
        end
      else
        opt(names, false, opts)
      end
    end

    def opt(name, required, opts)
      type    = opts[:type] || String

      _if     = opts[:if]
      _unless = opts[:unless]

      # проверить выполнение условий (если они есть)
      cond_fail = !_conditions_satisfied?(_if, _unless)

      p = _convert_if_exists(type, name)

      if ( !(required ^ !cond_fail) && p.nil?)
        raise ParameterMissing.new(name)
      end

      if !p.nil?
        params[name] = p
      end
    end

    def _error
      render inline: { message: 'req' }.to_json
    end

    def _convert_if_exists(type, name)
      if params.has_key?(name)
        # пытаемся перевести параметр в указанный тип
        _to_type(type, params[name], name)
      end
    end

    def _conditional?(_if, _unless)
      !_if.nil? || !_unless.nil?
    end

    def _conditions_satisfied?(_if, _unless)
      _if_result     = _get_result(_if)     unless _if.nil?
      _unless_result = _get_result(_unless) unless _unless.nil?

      if (!_if.nil? && !_if_result) ||
        (!_unless.nil? && _unless_result)
        then
        false
      else
        true
      end
    end

    def _to_type(type, v, name)
      result = if type == Boolean && StringUtils.boolean?(v)
                 StringUtils.to_bool(v)
               else
                 result = v
               end

      if result.nil?
        raise ConvertError.new(name, type)
      end

      return result
    end

    def _get_result(value)
      result = if value.is_a?(Symbol)
                 send(_if)
               elsif value.is_a?(String)
                 instance_eval(value)
               elsif _boolean?(value)
                 result = value
               end

      if _boolean?(result)
        return result
      end

      raise ArgumentError.new("Cannot return result")
    end

    def _boolean?(value)
      if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        true
      else
        false
      end
    end
  end
end
