module Web::Controllers::Date
  class Display
    include Web::Action
    include Hanami::Validations

    params do
      required(:year).filled(:int?)
      required(:month).filled(:int?, included_in?: 1..12)
      required(:day).filled(:int?, included_in?: 1..31)
    end

    def call(params)
      if params.valid?
        @year = params[:year]
        @month = params[:month]
        @day = params[:day]
        days_in_month = Date.new(@year, @month, -1).day
        if @day > days_in_month
          self.status = 422
          params.errors.add :day, "for month #{@month}, day must be between 1 and #{days_in_month}"
          return
        end
        
      else
        self.status = 422
      end
    end
  end
end
