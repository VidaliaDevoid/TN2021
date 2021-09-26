module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :count

    def instances
      self.count ||= 0
    end

    def add_instance
      self.count ||= 0
      self.count += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance
    end
  end
end
