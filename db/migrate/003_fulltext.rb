class Fulltext < ActiveRecord::Migration
  def self.up
  end

  def self.down
  end
end

module FullText

  class CreateFullText  

    def doit
      # debugging
      f = File.new("debugger.txt","w")
      f << "\ncreating index for: " + RAILS_ENV
      
      if( RAILS_ENV == "development" )
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_development`.`movies` ADD FULLTEXT `index_movies`(`title`, `synopsis`)")
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_development`.`festivals` ADD FULLTEXT `index_festivals`(`title`, `description`)")
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_development`.`events` ADD FULLTEXT `index_events`(`title`, `description`)")
         f << "\nPending no errors, development indexes created."
      elsif( RAILS_ENV == "production" )
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_production`.`movies` ADD FULLTEXT `index_movies`(`title`, `synopsis`)")
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_production`.`festivals` ADD FULLTEXT `index_festivals`(`title`, `description`)")
         ActiveRecord::Base.connection.execute("ALTER TABLE `lightningent_production`.`events` ADD FULLTEXT `index_events`(`title`, `description`)")      
         f << "\nPending no errors, production indexes created."
      end
      
      f << "\nIf no warnings, indexes created."      
      f.close
    end
  
  end
  
end

# cft = FullText::CreateFullText.new
# cft.doit
