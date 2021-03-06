module RyFilemanager
  module SaphiraApplicationControllerExtension
    module ClassMethods
      
    end

    module InstanceMethods
      def image_for(item)
        case item.item_type
        when 'folder'
          "admin/icons/small/grey/Folder.png"
        else
          "admin/icons/small/grey/Document.png"
        end
      end
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
      receiver.layout 'admin'
      receiver.helper ::Admin::AdminHelper
      receiver.helper_method :image_for
      receiver.before_filter :authenticate_user!, :except => [:login, :logout]
      receiver.check_authorization
      receiver.authorize_resource :class => "Saphira::FileItem"
    end
  end
end