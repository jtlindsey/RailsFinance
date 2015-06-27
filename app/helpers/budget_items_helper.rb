module BudgetItemsHelper

  def over_budget_tag(budget_item)
    #if user is equal or over budget
    #byebug
    if budget_item.budget_spent(budget_item.period) != 0 && (budget_item.budget_spent(budget_item.period) / budget_item.amount * 100) >= 100
      "progress-bar-danger"
    #if user spents more than 75% of budget
    elsif budget_item.budget_spent(budget_item.period) != 0 && (budget_item.budget_spent(budget_item.period) / budget_item.amount * 100) > 75
      "progress-bar-warning"
    else
      ""
    end
  end

  def none_zero_or_nil(budget_item)

  end

  def calculated_bar_width(budget_item)
    #byebug
    case 
    #if budget spent !=0 and if user spent more than budget do...
    when budget_item.budget_spent(budget_item.period) != 0 && (budget_item.budget_spent(budget_item.period) / budget_item.amount * 100) > 100
      100
    #if budget spent !=0 and if user spent less than or equal to budget do...
    when budget_item.budget_spent(budget_item.period) != 0 && (budget_item.budget_spent(budget_item.period) / budget_item.amount * 100) <= 100
      (budget_item.budget_spent(budget_item.period) / budget_item.amount * 100)
    else
      #if user spent nothing from budget
      0
    end
  end

  def status_text(budget_item)
    if budget_item.amount >= budget_item.budget_spent(budget_item.period)
      budget_item.budget_spent(budget_item.period)
    else
      "#{budget_item.budget_spent(budget_item.period)} ( $#{budget_item.budget_spent(budget_item.period) - budget_item.amount} Over Budget! )"
    end
  end 

end
