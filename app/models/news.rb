class News < ActiveRecord::Base

  def News.returnNews
    sql = " ( SELECT id, title, body, byline, date as d, 'Prelease' as controller FROM preleases ORDER BY date DESC limit 0,3 )"
    sql += " UNION "
    sql += "( SELECT id, title, description, subtitle, festivaldate as d, 'Festival' as controller FROM festivals ORDER BY festivaldate DESC limit 0,3 )"
    sql += " UNION "
    sql += "( SELECT id, title, description, imagesmall, eventdate as d, 'Event' as controller FROM events ORDER BY eventdate DESC LIMIT 0,3 )"
    sql += " UNION "
    sql += " ( SELECT id, title, synopsis, link, releasedate as d, 'Movie' as controller FROM movies ORDER BY releasedate DESC limit 0,3 )"
    #sql += " ORDER BY d DESC"
    news = Event.find_by_sql(sql)
    return news
  end
  
end
