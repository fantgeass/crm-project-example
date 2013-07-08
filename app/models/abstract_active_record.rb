class AbstractActiveRecord < ActiveRecord::Base
  self.abstract_class = true

  stampable #userstamp

  # include pacecar in ascendant context
  def self.inherited(subclass)
    super
    subclass.class_eval do
      include Pacecar
    end
  end

end