
class ProcessCsv    
  require 'csv'
  require 'net/http'
  def initialize(csv_url)
    @csv_url = csv_url
  end

  def proce
    uri = URI(@csv_url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Mycsv.create(row.to_hash.delete_if { |k,v| v.nil? })
    end
  end
end