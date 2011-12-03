if defined?(Mongoid::Document)

class Mongoid::Relations::Metadata
  attr_accessor :form
end

module Mongoid
  module Document
    def self.included(base)
      Rails.add_child(:models, base)
      p " #{base} include #{self}"
      def base.inherited(child)
        Rails.add_inherit(:models, child)
        p " #{child} inherit #{self}"
      end

      base.class_eval do
        include ModelManage::Base
        include ModelManage::Mongoid
        include MongoidAsActiveRecord::Base
      end
    end
  end
end

module ModelManage
  module Mongoid
    def self.included(base)
      def base.key(* keys)
        const_set :KEYS, keys.map(&:to_s)
        super
      end
      def base.referenced_in(name, options = {})
        super
        relation_form_set name, options
      end
      def base.references_many(name, options = {})
        super
        relation_form_set name, options
      end
      def base.embedded_in(name, options = {})
        super
        relation_form_set name, options
      end
      def base.embeds_many(name, options = {})
        super
        relation_form_set name, options
      end
      def base.references_and_referenced_in_many(name, options = {})
        super
        relation_form_set name, options
      end

      # for sinple form
      def column_for_attribute(attribute_name)
        self.class.forms[attribute_name.to_s]
      end
    end
  end
end

end 
