require 'time'
module Address_Book_Module
#should this methods be stored here? or inside SESSION?

# can I access the ENTRIES and convert them to HASHes and put them back?

# takes a file, returns an array of objects


class Directory

  attr_reader :accounts, :accounts_index, :file
  attr_accessor :accounts

  def initialize(file)
    create_account_array
    @file = file
    @accounts_index = WordIndex.new(@accounts).index
  end 

  def create_account_array
    @accounts = File.open(@file, "rb"){|from_file| Marshal.load(from_file)}
  end 

  def accounts 
    @accounts 
  end 

  def search(target)
    begin
      result =  @accounts_index[target]
      if result.nil?
        puts "#{result} didn't return a match. Try again"
      else
        account_hash = {}
        result.each_with_index{|acc, index| account_hash[index] = acc}
        if account_hash.length == 1
          return account_hash[0]
        else
          account_hash.each_key{|key| puts "#{key}: #{account_hash[key].name}"}
          selection = gets.chomp
          return account_hash[selection.to_i]
        end
      end
    rescue
      puts "account not found"
      exit
    end


    def delete_account(entry)
      @accounts.delete(entry)
    end


  end

class WordIndex
  def initialize(accounts)
    @accounts = accounts
  end

      def index
        information = ["name", "last_name", "first_name"]
        index_hash = {}
          @accounts.cycle(1) do |obj|
          index_hash[obj.name.downcase] = [] if index_hash[obj.name.downcase].nil?
          index_hash[obj.name.downcase].push(obj)
          index_hash[obj.last_name.downcase] = [] if index_hash[obj.last_name.downcase].nil?
          index_hash[obj.last_name.downcase].push(obj)
          index_hash[obj.first_name.downcase] = [] if index_hash[obj.first_name.downcase].nil?
          index_hash[obj.first_name.downcase].push(obj)
          index_hash[obj.city.downcase] = [] if index_hash[obj.city.downcase].nil?
          index_hash[obj.city.downcase].push(obj)
          index_hash[obj.state.downcase] = [] if index_hash[obj.state.downcase].nil?
          index_hash[obj.state.downcase].push(obj)
        end
        index_hash
      end
  end
end

def marshal_save(obj_array, file)
  File.open(file, "wb"){|f| f.write(Marshal.dump(obj_array))}
end


  def add_touch_point(entry)
      puts "Date? \#,\#,\# (year, month, day)"
      response = gets.chomp
      begin
        if response.include?("n")
          create_date = Time.now
        else
            match_set = response.scan(/(\d+)/)
            info = match_set.map{|int| int[0].to_i}
            new_time = Time.mktime(info[0], info[1],info[2])
            create_date = new_time
        end
        rescue
            puts "Did you put the year first?"
            add_touch_point(entry)
          else
          tp = Touch_Point.new(entry, create_date)
          entry.touch_points << tp
          save_update(entry)
          display_contact(entry)
          entry_menu(entry)
      end
  end

  def open_touch_points(obj)
      obj.touch_points
  end


      def save_entry(entry_info, database)
        new_entry = Entry.new(entry_info)
        updated_database = database.push(new_entry)
        updated_database
      end

      def save_update(entry)
        database.accounts.delete(entry)
        updated_database = database.accounts.push(entry)
        marshal_save(updated_database, ENTRIES)
        puts "#{entry.name}: updated"
      end

      def prepare_argument_hashes(objs)
        save_array = []
        objs.each{|obj| save_array << Marshal.dump(obj)}
        save_array
      end

      # def hard_save_directory(database, file)
      #   hash_array = prepare_argument_hashes(database)
      #   write_file = File.open(file, "w")
      #   write_file.puts hash_array
      #   write_file.close
      # end

      def simplify(database)
        database.map { |obj| obj.name.downcase.scan(/[\w]/).uniq}
      end

      def name_hasher(name)
          name_hash = {}
          name.map{|char| name_hash[char] = char}
          name_hash
      end

      def obj_to_fullname_hash(database)
        simple_name_database = simplify(database)
        name_hash_array = []
        simple_name_database.each do |obj|
          new_hash = {}
          obj.map do |letter|
          new_hash[letter] = letter
          end
          name_hash_array << name_hasher(obj)
        end
          name_hash_array
      end


      def capture_hash_and_index(hash, index,fudge_width)
            matches = []
            match = hash.values.join("")
            matches << [index, hash, fudge_width]
            matches
      end

      def calculate_fudge(search_hash, hash_name_array, search)
        hash_name_array.each_with_index do |hash, index|
        fudge_width = search_hash.merge(hash).length - search.length
        fudge_width <= 0 ? capture_hash_and_index(hash, index, matches, fudge_width) : next
         end
      end

      def best_match(matches, search_hash, database)
        final_match = matches.select{ |match| match[1].first == search_hash.first}.pop
        final_match
      end


      def hash_name_compare(search, database)
        hash_name_array = obj_to_fullname_hash(database)
        search_hash = name_hasher(search.downcase.split(""))
        matches = calculate_fudge(search_hash, hash_name_array, search)
        final_match = best_match(matches, search_hash, database)
        final_match
      end

      def value_checker(value, file)
        value_array = []
        value_file = File.open(file, "r")
        value_array.each{|entry| value_array << entry}
        time_now = Time.new
        value_array << "time: #{time_now.month}/#{time_now.day}/#{time_now.year}class:#{value.class}; #{value}"
        write_to_file = File.open(file, "w")
        write_to_file.puts value_array
      end

      def select_entry(search, database)
        selection = database.select{|obj| obj.name == search}
      end


      def reset_touch_points(obj_array)
        obj_array.each{|obj| obj.touch_points = []}
        obj_array
      end

      def search_exist?(search, database)
        exist = false
        directory.each do |entry|
          if entry.name == search
            exist = true
          else
            next
          end
        end
        exist
      end
  end
