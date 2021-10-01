module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def selected_ratings(rating)
    if (session[:ratings] != nil)
      if(session[:ratings].include? rating)
        return true
      else
        return false
      end
    else
      return false
    end
  end
  def bg_highlight(sort_column)
    if(session[:sort].to_s == sort_column)
      return 'bg_highlight'
    else
      return ''
    end
  end
end


