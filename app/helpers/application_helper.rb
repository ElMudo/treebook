module ApplicationHelper
  
  def can_display_status?(status)
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
  end
  
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
