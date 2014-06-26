module RedmineEasyCustomFields
  module Patches
    module CustomFieldsControllerPatch
      def self.included(base)
        base.class_eval do
          
          # Insert overrides here, for example:
          def index_with_plugin
            index_without_plugin
            
            @custom_field_tracker = params[:custom_field_tracker].to_i || -1
            
            if @custom_field_tracker==0 #ALL
                 puts "--------------- > INSIDE '0'"
              @custom_fields_by_type = CustomField.all.group_by {|f| f.class.name }
      
            elsif @custom_field_tracker==-1 #NO TRACKER
              puts "--------------- > INSIDE '-1'"
              scope = CustomField.joins("LEFT JOIN #{CustomField.table_name_prefix}custom_fields_trackers#{CustomField.table_name_suffix} ON #{CustomField.table_name_prefix}custom_fields_trackers#{CustomField.table_name_suffix}.custom_field_id = #{CustomField.table_name}.id").where('tracker_id IS NULL').uniq 
              @custom_fields_by_type = scope.all.group_by {|f| f.class.name } 
            else
              puts "--------------- > INSIDE 'else'"
              scope=CustomField.joins("INNER JOIN #{CustomField.table_name_prefix}custom_fields_trackers#{CustomField.table_name_suffix} ON #{CustomField.table_name_prefix}custom_fields_trackers#{CustomField.table_name_suffix}.custom_field_id = #{CustomField.table_name}.id").where('tracker_id = ?', @custom_field_tracker).uniq
              @custom_fields_by_type = scope.all.group_by {|f| f.class.name } 
            end
            
#            if @custom_fields_by_type.blank?
#              flash.now[:notice]="No Results to Show"
#            end
            
            render :action => "index"
          
          end
        
          alias_method_chain :index, :plugin 
          
          

        def rearrange_fields
          @custom_field_ids = params["custom_fields"]
          n = 0
          ActiveRecord::Base.transaction do
            @custom_field_ids.each do |id|
              custom_field = CustomField.find(id)
              custom_field.position = n
              n += 1
              custom_field.save
            end
          end
          render :json => {}
        end

          
          # This tells Redmine to allow me to extend show by letting me call it via "show_without_plugin" above.
          # I can outright override it by just calling it "def show", at which case the original controller's method will be overridden instead of extended.
      
        end
      end
    end
  end
end

