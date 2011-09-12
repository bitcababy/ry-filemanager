module RyFilemanager
  module Helpers
    module FormBuilder
      extend ActiveSupport::Concern
    
      def ry_option_field_ry_filemanager_image_crop(method, *args)
        options = args.extract_options!
        if options[:options] and options[:options][:file_item_id]
          options[:object] = ::Saphira::FileItem.find_by_id(options[:options][:file_item_id])
          
          self.saphira_image_crop(method, options)
        else
          "No image selected"
        end
      end
    end
  end
end