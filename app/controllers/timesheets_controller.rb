class TimesheetsController < ApplicationController
    before_action :authenticate_user!
    #before_action :set_time_sheet, only: [:show]
    def index
        @time_sheets = TimeSheet.all
        render json: @time_sheets
    end
    
    def show

    #@timesheet = TimeSheet.find(params[:id])

        @timesheet = TimeSheet.find_by(params[:user_id])
        # puts "yfudjyagfw#{@timesheet}"
        
  
        @total_time = @timesheet.Duration
        #@total_time = Duration(user_id: @timesheet.user_id, date: @timesheet.date)
        # @timesheet = TimeSheet.where(user_id: @timesheet.user_id, date: @timesheet.date).order(:time)
        # @total_time = TimeSheet.Duration(@timesheet.user_id, @timesheet.date)
        render json: {total_time: @total_time}
    end
  

    def create
        @time_sheet = current_user.time_sheets.new(time_sheet_params)

        if @time_sheet.save
           render json: @time_sheet, status: :created
        else
            render json: @time_sheet.errors.full_messages, status: :unprocessable_entity
         end
    end

    def update
        if @time_sheet.update(time_sheet_params)
            render json: @time_sheet
        else
            render json: @time_sheet.errors, status: :unprocessable_entity
        end
    end


    

    private

    def set_time_sheet
        @time_sheet = TimeSheet.find(params[:id])
    end

    def time_sheet_params
        params.require(:time_sheet).permit(:time, :type, :date, :user_id)
    end
end