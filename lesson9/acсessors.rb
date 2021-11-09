module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      # getter
      define_method(name) { instance_variable_get(var_name) }

      # setter
      define_method("#{name}=".to_sym) { |value| 
        instance_variable_set(var_name, instance_variable_get(var_name) || [])
        instance_variable_get(var_name).push(value)
      }

      define_method("#{name}_history") { instance_variable_get(var_name) }
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym
          
    # getter
    define_method(attr_name) { instance_variable_get(var_name) }

    # setter
    define_method("#{attr_name}=".to_sym) { |value| 
      if value.class == attr_class
        instance_variable_set(var_name, value)
      else
        raise "Wrong type."
      end
    }
  end
end

class TestClass
  extend Acсessors

  attr_accessor_with_history :var1, :var2
  strong_attr_accessor :var_string, String
end
