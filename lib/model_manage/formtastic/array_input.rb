module Formtastic
  module Inputs

    class ArrayInput
      include Base
      include Base::Stringish
      
      def to_html
        @object.each do |exp|
          input_wrapping do
            label_html <<
            builder.search_field(method, input_html_options)
          end
      end
    end
  end
end