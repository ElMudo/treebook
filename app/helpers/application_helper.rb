module ApplicationHelper
  
  def flash_class(type)
    case type
    when :notice
      return "alert-success"
    when :alert
      return "alert-error"
    else
      return ""
    end
  end
end
