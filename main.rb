require_relative 'navigation'
require_relative 'food'
require_relative 'exercise'
require_relative 'argv'


require 'tty-prompt'
require 'tty-table'
require 'rainbow'
require 'tty-font'
require 'text-table'

require 'csv'

# Ruby gems for table
def tables(food_cal_pairing)
    table = TTY::Table.new(%w[Food Calories], food_cal_pairing)
    puts Rainbow(table.render(:ascii)).silver
end

# CRUD for food/calorie.
def trackers(food_cal_pairing)
    system("clear")
    user_continue = true
    while user_continue == true
        tables(food_cal_pairing)
        Food.food_tracker_menu
        # Error handling via input
        user_edits = gets.chomp.strip.downcase
        case user_edits
        # Create/read/update
        when 'add'
            Food.add_food(food_cal_pairing)
    puts 'You have ended the program'
        # read/delete
        when 'remove'
            Food.remove_food(food_cal_pairing)
        when 'add total'
            Food.add_total(food_cal_pairing)
        # File handling
        when 'csv'
            Food.csv(food_cal_pairing)
        # exit loop, return back to menu
        when 'exit'
            return
        # Error handling
        else
            puts Rainbow("Invalid choice. Please select from add, remove, csv or exit.").purple
        end
    end
end

def workouts(exercise_list)
    system("clear")
    puts exercise_list.to_table if exercise_list.length >= 1
    user_continue = true
    while user_continue
        Exercise.exercise_menu
        exercise_input = gets.chomp.strip.downcase
        case exercise_input
        when 'add'
            Exercise.add(exercise_list)
        when 'delete'
            Exercise.delete(exercise_list)
        when 'shuffle'
            Exercise.shuffle(exercise_list)
        when 'text'
            Exercise.text(exercise_list)
        when 'exit'
            return
        else
            puts Rainbow("Invalid choice. Please select from add, delete, random, text or exit.").cyan
        end
    end
end

def argument_vectors
    Navigation.nav_menu if ARGV.length.zero?
    case ARGV[0]
    when '-h'
        ArgVectors.help
    when '-i'
        ArgVectors.info
    when '-g'
        ArgVectors.gems
    when -'e'
        trackers(food_cal_pairing)
    end
end

argument_vectors