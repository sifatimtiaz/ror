class Search < ActiveRecord::Base

  def Search.results(query,page,perpage)
    limit = "";
    if(page!=nil && perpage != nil)
      limit = "LIMIT "+( page.to_i != 0 ? (page.to_i * perpage.to_i) : page ).to_s+","+perpage.to_s
    end  
    
    query = query.gsub("%20"," ").downcase
    query = query.gsub(/[']/,"\\\\\'")
    sql = "( SELECT id, title, description, imagesmall, 'Event' as controller FROM events WHERE (lower(title) like '%"+query+"%' OR lower(description) like '%"+query+"%') )"
    sql += " UNION "
    sql += "( SELECT id, title, description, imagesmall, 'Festival' as controller FROM festivals WHERE (lower(title) like '%"+query+"%' OR lower(description) like '%"+query+"%') )"
    sql += " UNION "
    sql += " ( SELECT id, title, synopsis as description, postersmall as imagesmall, 'Movie' as controller FROM movies WHERE (lower(title) like '%"+query+"%' OR lower(synopsis) like '%"+query+"%'))"
    sql += " ORDER BY title ASC "+limit
        
    
    #query = query.gsub("%20"," ").downcase 
    #sql = "( SELECT id, title, description, imagesmall, 'Event' as controller, MATCH(title,description) AGAINST('"+query+"') as score FROM events WHERE MATCH(title,description) AGAINST('"+query+"') )"
    #sql += " UNION "
    #sql += "( SELECT id, title, description, imagesmall, 'Festival' as controller, MATCH(title,description) AGAINST('"+query+"') as score FROM festivals WHERE MATCH(title,description) AGAINST('"+query+"') )"
    #sql += " UNION "
    #sql += " ( SELECT id, title, synopsis as description, postersmall as imagesmall, 'Movie' as controller, MATCH(title,synopsis) AGAINST('"+query+"') as score FROM movies WHERE MATCH(title,synopsis) AGAINST('"+query+"') )"
    #sql += " ORDER BY score DESC "+limit
     
    res = Event.find_by_sql(sql)
    return res
  end
  
end
