require "ry-filemanager/saphira_application_controller_extension"
require "ry-filemanager/helpers/form_helper"
require "ry-filemanager/helpers/form_builder"

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
            ability.can :manage, [Saphira::FileItem]
          elsif user.role? :premium_user
            ability.can :read, [Saphira::FileItem]
          else
            ability.can :read, [Saphira::FileItem]
          end
          
          if user.role? :admin
            ability.can :manage, [Saphira::FileItem, Saphira::ImageVariant]
          end
        end
        
        # The javascripts required by saphira
        javascripts ['saphira/jquery.color.js', 'saphira/jquery.jcrop.js', 'ry-filemanager/jquery.nivo.slider.js']
        
        # The stylesheets required by ry-filemanager
        stylesheets ['saphira/application.css', 'ry-filemanager/application.css', 'ry-filemanager/themes/default/default.css']
      end
      
      # extend the saphira application controller with some helper methods and add some behaviors
      # like using the right layout and check authorizations
      Saphira::ApplicationController.send :include, RyFilemanager::SaphiraApplicationControllerExtension
      
      # extend the action view with some helpers for file selection
      ActionView::Base.send :include, RyFilemanager::Helpers::FormHelper
      ActionView::Helpers::FormBuilder.send :include, RyFilemanager::Helpers::FormBuilder
    end
  end
end