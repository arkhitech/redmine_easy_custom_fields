Redmine::Plugin.register :redmine_easy_custom_fields do
  name 'Redmine Easy Custom Fields'
  author 'Arkhitech'
  description 'This is a plugin for Redmine to implement tracker filter on issue custom fields and enable position change by drag and drop'
  url 'http://github.com/arkhitech/redmine_easy_custom_fields'
  author_url 'https://github.com/arkhitech'
  version '1.0.0'
  
  Rails.configuration.to_prepare do 
      require_dependency 'custom_field'
      require_dependency 'custom_fields_helper'
      require_dependency 'custom_fields_controller'
      require_dependency 'tracker'
      CustomFieldsController.send(:include, RedmineEasyCustomFields::Patches::CustomFieldsControllerPatch)
      CustomFieldsHelper.send(:include,RedmineEasyCustomFields::Patches::CustomFieldsHelperPatch)

    end
end
