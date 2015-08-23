module CsvHelper

  class SendUsersCSV

    def initialize(users, controller)
      @users      = users
      @controller = controller
      @view       = controller.view_context
      send_csv
    end

    def send_csv
      # http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-headers
      @controller.send_data render_csv,
        type:        "application/csv",
        filename:    "users-#{Date.today}.csv",
        disposition: "attachment"
    end

    def render_csv
      # Set options if needed (e.g. :col_sep, :headers, etc)
      # http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
      options = { headers: true }

      attributes = %w(id username sign_in_count created_at confirmed_at updated_at)

      @output = CSV.generate(options) do |csv|
        # Column names in a first row
        csv << attributes

        # Write each record as an array of strings
        @users.unscoped.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
      @output
    end
  end
end
