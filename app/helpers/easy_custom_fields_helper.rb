 module EasyCustomFieldsHelper
   include ApplicationHelper
   
     
  def tracker_options_for_select(selected)
  
    tracker_options = Tracker.sorted.map {|t| [t.id, t.name]} 
    tracker_options << ['none', 0]
    tracker_options.insert(0, ['all2', -1])
    
    options_for_select(tracker_options, selected.to_i)
      
  end
end
