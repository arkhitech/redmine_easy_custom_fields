require_dependency 'custom_fields_helper'
module RedmineEasyCustomFields
  module Patches
    module CustomFieldsHelperPatch
      def self.included(base)
        base.class_eval do
 
          def tracker_options_for_select(selected)

            tracker_options = Tracker.sorted.map {|t| [t.name, t.id]} 
            tracker_options.insert(0, ['all', 0])
            tracker_options.push(['none',-1])

            options_for_select(tracker_options, selected.to_i)

          end

        end
      end
    end
  end
end

