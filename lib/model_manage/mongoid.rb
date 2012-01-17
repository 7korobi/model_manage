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
        extend  ModelManage::Mongoid::ClassMethods
      end
    end
  end
end

class Mongoid::Relations::Metadata
  attr_accessor :form
end

module ModelManage
  module Mongoid
    module ClassMethods
      def key(* keys)
        const_set :KEYS, keys.map(&:to_s)
        super
      end
      def referenced_in(name, options = {})
        super
        relation_form_set name, options
      end
      def references_many(name, options = {})
        super
        relation_form_set name, options
      end
      def embedded_in(name, options = {})
        super
        relation_form_set name, options
      end
      def embeds_many(name, options = {})
        super
        relation_form_set name, options
      end
      def references_and_referenced_in_many(name, options = {})
        super
        relation_form_set name, options
      end
    end
  end
end
