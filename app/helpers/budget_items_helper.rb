module BudgetItemsHelper

#Income
  def over_income_budget_tag(budget_item)
    #if user income is equal or over budget
    #byebug
    if budget_item.budget_gain(budget_item.period, current_user) != 0 && (budget_item.budget_gain(budget_item.period, current_user) / budget_item.amount * 100) >= 100
      "progress-bar-success"
    #if user income is more than 75% of budget
    elsif budget_item.budget_gain(budget_item.period, current_user) != 0 && (budget_item.budget_gain(budget_item.period, current_user) / budget_item.amount * 100) > 75
      "progress-bar-info"
    else
      ""
    end
  end

  def calculated_income_bar_width(budget_item)
    case 
    #if budget spent !=0 and if user spent more than budget do...
    when budget_item.budget_gain(budget_item.period, current_user) != 0 && (budget_item.budget_gain(budget_item.period, current_user) / budget_item.amount * 100) > 100
      100
    #if budget spent !=0 and if user spent less than or equal to budget do...
    when budget_item.budget_gain(budget_item.period, current_user) != 0 && (budget_item.budget_gain(budget_item.period, current_user) / budget_item.amount * 100) <= 100
      (budget_item.budget_gain(budget_item.period, current_user) / budget_item.amount * 100)
    else
      #if user spent nothing from budget
      0
    end
  end

  def status_income_text(budget_item)
    if budget_item.amount >= budget_item.budget_gain(budget_item.period, current_user)
      number_to_currency(budget_item.budget_gain(budget_item.period, current_user))
    else
      "#{number_to_currency(budget_item.budget_gain(budget_item.period, current_user))} ( #{number_to_currency(budget_item.budget_gain(budget_item.period, current_user) - budget_item.amount)} Extra Income! )"
    end
  end 

  def status_income_text_header(budget_item)
    if budget_item.amount >= budget_item.budget_gain(budget_item.period, current_user)
      "#{number_to_currency(budget_item.budget_gain(budget_item.period, current_user))} of #{number_to_currency(budget_item.amount)}/#{budget_item.period} gained."
    else
      "#{number_to_currency(budget_item.budget_gain(budget_item.period, current_user))} of #{number_to_currency(budget_item.amount)}/#{budget_item.period} 
        ( #{number_to_currency(budget_item.budget_gain(budget_item.period, current_user) - budget_item.amount)} Extra Income! )"
    end
  end


































#Expense
  def over_budget_tag(budget_item)
    #if user is equal or over budget
    #byebug
    if budget_item.budget_spent(budget_item.period, current_user) != 0 && (budget_item.budget_spent(budget_item.period, current_user) / budget_item.amount * 100) >= 100
      "progress-bar-danger"
    #if user spents more than 75% of budget
    elsif budget_item.budget_spent(budget_item.period, current_user) != 0 && (budget_item.budget_spent(budget_item.period, current_user) / budget_item.amount * 100) > 75
      "progress-bar-warning"
    else
      ""
    end
  end

  def calculated_bar_width(budget_item)
    case 
    #if budget spent !=0 and if user spent more than budget do...
    when budget_item.budget_spent(budget_item.period, current_user) != 0 && (budget_item.budget_spent(budget_item.period, current_user) / budget_item.amount * 100) > 100
      100
    #if budget spent !=0 and if user spent less than or equal to budget do...
    when budget_item.budget_spent(budget_item.period, current_user) != 0 && (budget_item.budget_spent(budget_item.period, current_user) / budget_item.amount * 100) <= 100
      (budget_item.budget_spent(budget_item.period, current_user) / budget_item.amount * 100)
    else
      #if user spent nothing from budget
      0
    end
  end

  def status_text(budget_item)
    if budget_item.amount >= budget_item.budget_spent(budget_item.period, current_user)
      number_to_currency(budget_item.budget_spent(budget_item.period, current_user))
    else
      "#{number_to_currency(budget_item.budget_spent(budget_item.period, current_user))} ( #{number_to_currency(budget_item.budget_spent(budget_item.period, current_user) - budget_item.amount)} Over Budget! )"
    end
  end 

  def status_text_header(budget_item)
    if budget_item.amount >= budget_item.budget_spent(budget_item.period, current_user)
      "#{number_to_currency(budget_item.budget_spent(budget_item.period, current_user))} of #{number_to_currency(budget_item.amount)}/#{budget_item.period} spent."
    else
      "#{number_to_currency(budget_item.budget_spent(budget_item.period, current_user))} of #{number_to_currency(budget_item.amount)}/#{budget_item.period} 
        ( #{number_to_currency(budget_item.budget_spent(budget_item.period, current_user) - budget_item.amount)} Over Budget! )"
    end
  end

end
