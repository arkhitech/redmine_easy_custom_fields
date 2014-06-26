class EasyCustomFieldsController < ApplicationController
layout 'admin'

  before_filter :require_admin
  
  def index
  end
  
  def require_admin
    return unless require_login
    if !User.current.admin?
      render_403
      return false
    end
    true
  end
 
  
 helper :easy_custom_fields
 include EasyCustomFieldsHelper
  
end