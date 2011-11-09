module ModelManage
  module Base
    def self.included(base)
      base.class_eval do
      end

      def base.forms
        const_get(:FORMS)
      end

      def base.key?(key)
        const_get(:KEYS).member? key.to_s
      rescue
        const_set :KEYS, []
        false
      end

      forms_field = base.superclass.forms.dup rescue {}.with_indifferent_access
      base.const_set :FORMS, forms_field

      def base.field(name, options = {})
        min =   1

        validates = {}
        validates[:in] = options.delete(:in)  || options.delete(:within)
        if options[:limit] && (! validates[:in])
          validates[:in] = (min..options.delete(:limit)) 
        end

        validates[:allow_nil  ] = options.delete(:allow_nil)   || false
        validates[:allow_blank] = options.delete(:allow_blank) || false

        super
        null_ok = validates[:allow_nil] || validates[:allow_blank]
        form_attributes = {
          owner:   self,
          name:    name.to_s,
          type:    options[:type] || String,
          limit:   nil,
          null:    null_ok,
          primary: key?(name),
          scale:   nil
        }

        if validates[:in].present?
          validates_length_of name, validates
          form_attributes[:limit] = validates[:in].max
          form_attributes.merge!(validates)
        end

        forms[name] = OpenStruct.new(form_attributes)
      end

      def base.relation_form_set(name, options = {})
        relation_attributes = {
          owner:    self,
          name:     name.to_s,
          options:  options
        }.tap{|o| o[:data] = o.dup }
        relation = relations[name.to_s]
        relation.form = OpenStruct.new(relation_attributes)
      end
    end
  end
end