module RyFilemanager
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern
    
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
    
      def ry_option_field_ry_filemanager_file_selector(object_name, method, options = {})
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << select(object_name, method, nested_set_options(Saphira::FileItem) {|i| "#{'-' * i.level} #{i.name}" }, 
          :selected => options[:value],
          :disabled => Saphira::FileItem.where(:item_type => Saphira::FileItem::TYPE_FOLDER).map { |r| r.id }
        )
        output_buffer
      end
      
      def ry_option_field_ry_filemanager_folder_selector(object_name, method, options = {})
        output_buffer = ActiveSupport::SafeBuffer.new
        Saphira::FileItem.where(:item_type => Saphira::FileItem::TYPE_FOLDER).scoping do
          output_buffer << select(object_name, method, nested_set_options(Saphira::FileItem) {|i| "#{'-' * i.level} #{i.name}" }, 
            :selected => options[:value]
          )
        end
        output_buffer
      end
      
      def ry_option_field_ry_filemanager_image_variant_selector(object_name, method, options = {})
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << select(object_name, method, ::Saphira::ImageVariant.all.map{|i| [i.name, i.id] }, 
          :selected => options[:value]
        )
        output_buffer
      end
    end
  end
end