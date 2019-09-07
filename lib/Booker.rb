=begin
    User Stories

    As a user of the hotel system...
        I can access the list of all of the rooms in the hotel
        I can get a reservation of a room for a given date range
        I can access the list of reservations for a specific date, so that I can track reservations by date
        I can get the total cost for a given reservation
        I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range

Details

    The hotel has 20 rooms, and they are numbered 1 through 20
    Every room is identical, and a room always costs $200/night
    The last day of a reservation is the checkout day, so the guest should not be charged for that night
    When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
    For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
=end

require "date"
require_relative "date_range.rb"

module Hotel
  class Booker
    attr_reader :guests, :rooms
    attr_accessor :reservations, :room_list

    def initialize(number_of_rooms: 20)
      @guests = []

      #HashMap<reservationId, HashMap <roomId, daterange>>
      @reservationsHistory = {}

      #Initialize the reservationsList hashmap
      @reservations = {}

      # connect_res
      @room_list = []
      room_id = 1
      while room_id <= number_of_rooms
        room_list.push(room_id)
        room_id+=1
        @reservations[room_id] = []
      end
    end

    def select_room #Selects a room for a reservation on a given date
    end

    def getReservation(reservationId)
      return @reservationsHistory[reservationId]
    end

    def makeReservation(daterange)
      free_rooms = getFreeRooms(daterange)
      reserveRoom = 1
      roomId =getFreeRoom(date)
      
      if(roomId != 0)
        reserveRoom= reservation.addReservation(roomId, daterange)
      end
    
      if (reserveRoom==0)
        room_booked = {}
        room_booked[roomId] = date_range
        reservationsHistory.add(reservationId+=1, roomBooked)
      end
    end

    def addReservation(roomId, daterange)
      #Adds new daterange to the specific room if daterange is not booked and returns success code 0. Else returns code 1.
      if(@reservations.key?(roomId) && room_free?(room_id, daterange))
          @reservations[roomId].push(daterange)
        return 0
      end

      return 1
    end

    def removeReservation(roomId, daterange)
      #Removes the given daterange from the list for the given room
      if(@reservations.key?(roomId))
        @reservations[roomId].delete(daterange)
      end
    end

    # Get the first free room
    def getFreeRoom(date)
      free_room = 0
      @reservations.each_key do |room_id|
        if room_free(room_id, date) 
          free_room = room_id
        end
      end

      return free_room
    end

    def room_free?(room_id, date)
      is_room_free = true
      @reservations[room_id].each do |reserved_date|
        if(date.intersects(reserved_date))
          is_room_free = false
          break
        end
      end

      return is_room_free
    end

    def getReservedRooms(date)
      #Get the list of list of daterange (values of the hashmap) and iterate thru the list. When the date matches get the key(roomId) and store in local list. Return the list of rooms
      reserved_rooms = []
      @reservations.each_key do |room_id|
        @reservations[room_id].each do |date_range|
          if date == date_range
            reserved_rooms.push(room_id)
            break
          end
        end
      end

      return reserved_rooms
    end
  private

  def connect_res
    # @reservations.each do |reservation|
    #   guest = find_guest(reservation.guest_name)
    # end
  end
end