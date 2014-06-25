class EasyCustomFieldsController < ApplicationController
layout 'admin'

  before_filter :require_admin
  
  def index
   
   @custom_field_tracker = params[:custom_field_tracker] || -1

    #CustomField.first.tracker_ids
    #Tracker.joins(:custom_fields).where('custom_fields.id' => 1)
    #Tracker.joins(:custom_fields).where(:id=>'1')
    #scope = CustomField.where(:tracker_ids=>@custom_field_tracker)

    if @custom_field_tracker==-1 || @custom_field_tracker=='-1' #ALL
       @custom_fields_by_type = CustomField.all.group_by {|f| f.class.name }
      
    elsif @custom_field_tracker==0 || @custom_field_tracker=='0' #NO TRACKER
      @custom_fields_by_type = CustomField.scoped   
    else
    scope=Tracker.joins(:custom_fields).where(:id=>@custom_field_tracker)
    scope = scope.like(params[:name]) if params[:name].present?
    @custom_fields_by_type = scope.all
    end
    
    @tab = params[:tab] || 'IssueCustomField'
    
    render :action => "index", :layout => false if request.xhr?
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