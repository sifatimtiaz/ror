class Newspress < ActiveRecord::Base

  def Newspress.returnNewspress
    sql = " ( SELECT id, title, body, date as d, 'Prelease' as controller FROM preleases ORDER BY date DESC limit 0,3 )"
    sql += " ORDER BY d ASC"
    newspress = Event.find_by_sql(sql)
    return newspress
  end
  
end