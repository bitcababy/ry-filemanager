require "ry-filemanager/saphira_application_controller_extension"
require "ry-filemanager/helpers/form_helper"

module RyFilemanager
  class Engine < Rails::Engine
    isolate_namespace RyFilemanager
    
    config.to_prepare do
      # Configure the railsyard plugin
      Ry::Plugin::Manager.instance << Ry::Plugin::Base.configure(RyFilemanager::Engine) do
        # setting the root path of the plugin
        root_path File.expand_path('../../../',  __FILE__)
        
        # mounting the engine
        mount ::Saphira::Engine => '/admin/filemanager', :as => 'filemanager'
        
        # the admin menu file
        admin_menu 'ry-filemanager/admin/menu'
        
        # defining abilities
        ability do |ability, user|
          if user.role? :article_writer
            ability.can :read, [Saphira::FileItem]
          elsif user.role? :premium_user
            ability.can :read, [Saphira::FileItem]
          else
            ability.can :read, [Saphira::FileItem]
          end
        end
      end
      
      # extend the saphira application controller with some helper methods and add some behaviors
      # like using the right layout and check authorizations
      Saphira::ApplicationController.send :include, RyFilemanager::SaphiraApplicationControllerExtension
      
      # extend the action view with some helpers for file selection
      ActionView::Base.send :include, RyFilemanager::Helpers::FormHelper
    end
  end
end