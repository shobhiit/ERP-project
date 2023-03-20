class TimeSheet < ApplicationRecord

    belongs_to :user
    self.inheritance_column = :inheritance_type
  
    def Duration
      # Select all TimeSheet records with type 0 or 1, and order them by date and time
      @time_sheets = TimeSheet.where(user_id: user_id, date: date).order(:time)
      total_time = 0
      last_true_workhour = nil
      
      @time_sheets.each do |workhour|
        if workhour.type # true
          last_true_workhour = workhour
        elsif last_true_workhour.present?
          time_diff = (workhour.time - last_true_workhour.time) / 3600.0
          total_time += time_diff
          last_true_workhour = nil
        
        end
      end
    
      if last_true_workhour.present?
        current_time = Time.current.in_time_zone('New Delhi')
        time_diff = (current_time - last_true_workhour.time) / 3600.0
  
        total_time += time_diff
      end
        
      Time.at(total_time * 3600).strftime("%H:%M:%S")
    end
end  
  