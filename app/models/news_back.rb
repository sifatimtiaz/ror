class News < ActiveRecord::Base

  def News.returnNews
    sql = " ( SELECT id, title, body, date as d, 'Prelease' as controller FROM preleases ORDER BY date DESC limit 0,3 )"
    sql += " UNION "
    sql += "( SELECT id, title, description, festivaldate as d, 'Festival' as controller FROM festivals ORDER BY festivaldate DESC limit 0,3 )"
    sql += " UNION "
    sql += "( SELECT id, title, description, eventdate as d, 'Event' as controller FROM events ORDER BY eventdate DESC LIMIT 0,3 )"
    sql += " UNION "
    sql += " ( SELECT id, title, synopsis, releasedate as d, 'Movie' as controller FROM movies ORDER BY releasedate DESC limit 0,3 )"
    sql += " ORDER BY d DESC"
    news = Event.find_by_sql(sql)
    return news
  end
  
end
