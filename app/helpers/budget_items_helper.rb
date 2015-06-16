module BudgetItemsHelper

  def over_budget_tag(budget_item)
    if budget_item.budget_spent != 0 && (budget_item.budget_spent / budget_item.amount * 100) > 100
      "progress-bar-danger"
    elsif budget_item.budget_spent != 0 && (budget_item.budget_spent / budget_item.amount * 100) > 75
      "progress-bar-warning"
    else
      ""
    end
  end

  def calculated_bar_width(budget_item)
    if budget_item.budget_spent != 0 && (budget_item.budget_spent / budget_item.amount * 100) > 100
      100
    else
      (budget_item.budget_spent / budget_item.amount * 100)
    end
  end

  def status(budget_item)
    if budget_item.amount >= budget_item.budget_spent
      budget_item.budget_spent
    else
      "#{budget_item.budget_spent} ( $#{budget_item.budget_spent - budget_item.amount} Over Budget! )"
    end
  end 

end
