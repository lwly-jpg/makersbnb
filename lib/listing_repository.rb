require_relative 'listing'
require_relative 'booking'

class ListingRepository
  def all
    sql = 'SELECT * FROM listings;'
    result_set = DatabaseConnection.exec_params(sql, [])

    listings = []
    result_set.each do |record|
      listing = Listing.new
      listing.id = record['id'].to_i
      listing.name = record['name']
      listing.address = record['address']
      listing.city = record['city']
      listing.country = record['country']
      listing.ppn = record['ppn']
      listing.description = record['description']
      listing.host_id = record['host_id'].to_i
      listings << listing
    end
    
    return listings
  end

  def find(id)
    sql = 'SELECT * FROM listings WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    result_set.each do |record|
      listing = Listing.new
      listing.id = record['id'].to_i
      listing.name = record['name']
      listing.address = record['address']
      listing.city = record['city']
      listing.country = record['country']
      listing.ppn = record['ppn']
      listing.description = record['description']
      listing.host_id = record['host_id'].to_i

      return listing
    end
  end

  def create(listing)
    sql = 'INSERT INTO listings (name, address, city, country, ppn, description, host_id, available_start, available_end) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);'
    DatabaseConnection.exec_params(sql, [listing.name, listing.address, listing.city, listing.country, listing.ppn, listing.description, listing.host_id, listing.available_start, listing.available_end])
  end

  def find_bookings(listing_id)
    sql = 'SELECT listings.id AS listing_id, name, address, city, country, ppn, description, host_id, available_start, available_end, bookings.id AS booking_id, date, user_id AS customer_id, approved FROM listings
    JOIN bookings ON listing_id = listings.id
    WHERE listings.id = $1;'

    result_set = DatabaseConnection.exec_params(sql, [listing_id])
    listing = Listing.new
    result_set.each do |record|
      
      listing.id = record['listing_id'].to_i
      listing.name = record['name']
      listing.address = record['address']
      listing.city = record['city']
      listing.country = record['country']
      listing.ppn = record['ppn']
      listing.description = record['description']
      listing.host_id = record['host_id'].to_i
      listing.available_start = record['available_start']
      listing.available_end = record['available_end']

      booking = Booking.new
      booking.id = record['booking_id'].to_i
      booking.date = record['date']
      booking.user_id = record['customer_id'].to_i
      booking.approved = record['approved']
      listing.bookings << booking
    end
    return listing
  end

  # method to list dates up to and including start + end, as well as removing the approved dates

  def give_date_range(id)
    sql = 'SELECT * FROM listings WHERE id = $1'
    sql2 = 'SELECT * FROM bookings WHERE listing_id = $1'
    result_set = DatabaseConnection.exec_params(sql, [id])
    result_set2 = DatabaseConnection.exec_params(sql2, [id])

    dates = []
    approved_booking_dates = []

    result_set.each do |record|
      listing = Listing.new
      listing.id = record['listing_id'].to_i
      listing.name = record['name']
      listing.address = record['address']
      listing.city = record['city']
      listing.country = record['country']
      listing.ppn = record['ppn']
      listing.description = record['description']
      listing.host_id = record['host_id'].to_i
      listing.available_start = record['available_start']
      listing.available_end = record['available_end']
      dates << (listing.available_start..listing.available_end).map { |date| date }.select { |date| (date[8..9].to_i < 32 && date[5..6] != "00") && (date[5..6].to_i < 13 && date[8..9] != "00") }
    end 
    result_set2.each do |record|
      booking = Booking.new
      booking.id = record['booking_id'].to_i
      booking.date = record['date']
      booking.user_id = record['customer_id'].to_i
      booking.approved = record['approved']
      if booking.approved == "t"
        approved_booking_dates << booking.date
      else
        nil
      end    
    end  
    return dates.flatten - approved_booking_dates
  end
end