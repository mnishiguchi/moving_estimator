# ==> response headers
# http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-headers
filename = "users-#{Date.today}.csv"
response.headers["Content-Disposition"] = "attachment; filename='#{filename}'"

# ==> options (:col_sep, :headers, etc)
# http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#DEFAULT_OPTIONS
options = {}

# ==> column names
attributes = %w(id username sign_in_count created_at confirmed_at updated_at)

CSV.generate(options) do |csv|
  # table header
  csv << attributes

  # table body
  @users.unscoped.each do |user|
    csv << attributes.map{ |attr| user.send(attr) }
  end
end
