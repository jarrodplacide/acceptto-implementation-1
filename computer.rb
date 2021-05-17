#!/usr/bin/ruby
#
class Computer
  # Remove display method from Ruby Object
  undef_method :display 

  COMPONENTS = %w[keyboard mouse display cpu]
  MAX_PRICE = 99

  def initialize(computer_id, data_source)
    @id = computer_id if
    @data_source = data_source
  end

  def method_missing(method, *args)
    if COMPONENTS.include?(method.to_s) && @data_source.respond_to?("get_#{method}_info")
      component_format get_component_info method 
    else
      super 
    end
  end

  def respond_to_missing?(method, *args)
    COMPONENTS.include? method.to_s || super 
  end

  private 
    def get_component_info(component)
      info = @data_source.send("get_#{component}_info", [@id])
      price = @data_source.send("get_#{component}_price", [@id])
      return component, info, price
    end

    def component_format(component_info)
      component, info, price = component_info 
      output = "#{component.capitalize}: #{info} ($#{price})"
      unless price > MAX_PRICE
        output 
      else
        "* #{output}"
      end
    end
end
