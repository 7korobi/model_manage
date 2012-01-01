# -*- coding: utf-8 -*-
module Formtastic
  module Helpers
    module InputHelper

      def input(method, options = {})
        options = options.dup # Allow options to be shared without being tainted by Formtastic
        options[:as] ||= default_input_type(method, options)

        klass = input_class(options[:as])
        klass.new(self, template, @object, @object_name, method, options).to_html
      end

      protected

      def default_input_type(method, options = {}) #:nodoc:
        if @object
          return :select  if reflection_for(method)

          return :file    if is_file?(method, options)
        end

        if column = column_for(method)
          # Special cases where the column type doesn't map to an input method.
          case column.type
          when String, :string
            return :password  if method.to_s =~ /password/
            return :country   if method.to_s =~ /country$/
            return :time_zone if method.to_s =~ /time_zone/
            return :email     if method.to_s =~ /email/
            return :url       if method.to_s =~ /^url$|^website$|_url$/
            return :phone     if method.to_s =~ /(phone|fax)/
            return :search    if method.to_s =~ /^search$/
          when Integer, :integer
            return :select    if reflection_for(method)
            return :number
          when Float, Decimal, :float, :decimal
            return :number
          when Time, :timestamp
            return :string
          when Array
            return :array
          end

          # Try look for hints in options hash. Quite common senario: Enum keys stored as string in the database.
          return :select    if column.type == :string && options.key?(:collection)
          # Try 3: Assume the input name will be the same as the column type (e.g. string_input).
          return column.type
        else
          return :select    if options.key?(:collection)
          return :password  if method.to_s =~ /password/
          return :string
        end
      end

      def column_for(method) #:nodoc:
        @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)
      end

      # Takes the `:as` option and attempts to return the corresponding input class. In the case of
      # `:as => :string` it will first attempt to find a top level `StringInput` class (to allow the
      # application to subclass and modify to suit), falling back to `Formtastic::Inputs::StringInput`.
      #
      # This also means that the application can define it's own custom inputs in the top level
      # namespace (eg `DatepickerInput`).
      #
      # @param [Symbol] as A symbol representing the type of input to render
      # @raise [Formtastic::UnknownInputError] An appropriate input class could not be found
      # @return [Class] An input class constant
      #
      # @example Normal use
      #   input_class(:string) #=> Formtastic::Inputs::StringInput
      #   input_class(:date) #=> Formtastic::Inputs::DateInput
      #
      # @example When a top-level class is found
      #   input_class(:string) #=> StringInput
      #   input_class(:awesome) #=> AwesomeInput
      def input_class(as)
        @input_classes_cache ||= {}
        @input_classes_cache[as] ||= begin
          begin
            begin
              custom_input_class_name(as).constantize
            rescue NameError
              standard_input_class_name(as).constantize
            end
          rescue NameError
            raise Formtastic::UnknownInputError
          end
        end
      end

      # :as => :string # => StringInput
      def custom_input_class_name(as)
        "#{as.to_s.camelize}Input"
      end

      # :as => :string # => Formtastic::Inputs::StringInput
      def standard_input_class_name(as)
        "Formtastic::Inputs::#{as.to_s.camelize}Input"
      end

    end
  end
end
