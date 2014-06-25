Redmine::Plugin.register :redmine_easy_custom_fields do
  name 'Redmine Easy Custom Fields plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  Rails.configuration.to_prepare do 
      require_dependency 'custom_field'
      require_dependency 'custom_fields_helper'
      require_dependency 'custom_fields_controller'
      require_dependency 'tracker'
      CustomFieldsController.send(:include, RedmineEasyCustomFields::Patches::CustomFieldsControllerPatch)
      CustomFieldsHelper.send(:include,RedmineEasyCustomFields::Patches::CustomFieldsHelperPatch)

    end
end
