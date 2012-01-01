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

if defined?(SimpleForm) || defined?(Formtastic)
      base.class_eval do
        def column_for_attribute(attribute_name)
          self.class.forms[attribute_name.to_s]
        end
      end
end
if defined?(Formtastic)
      def base.content_columns
        forms.values
      end

      def base.reflections
        relations
      end
end
if defined?(RailsERD)
      def base.inheritance_column
        '_type'
      end

      def base.columns
        forms.values
      end

      def base.columns_hash
        forms
      end

      def base.descends_from_active_record?
        Rails.child_models.member? self
      end

      def base.reflect_on_all_associations(macro = nil)
        association_reflections = relations.values
        macro ? relations.select { |reflection| reflection.macro == macro } : association_reflections
      end

      def base.base_class
        class_of_active_record_descendant(self)
      end

      def base.class_of_active_record_descendant(klass)
        if not Rails.models.member? klass.superclass
          klass
        else
          class_of_active_record_descendant(klass.superclass)
        end
      end
end
    end
  end
end


if defined?(RailsERD)
  module ModelManage
    module Metadata
      def options
        form.data.merge(self)
      end
      def active_record
        form.owner
      end
      def check_validity!
        nil
      end
      def belongs_to?
        [:referenced_in, :embedded_in].member? macro
      end
      def collection?
        not belongs_to?
      end
      def through_reflection
        active_record.relations[ form.options[:through].to_s ]
      end
    end
  end

  class Mongoid::Relations::Metadata
    include ModelManage::Metadata
  end

  module ActiveRecord
    class Base
      def self.descendants
        Rails.models
      end
    end
  end
end 

end
