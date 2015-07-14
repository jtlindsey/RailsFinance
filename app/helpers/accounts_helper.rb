module AccountsHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  #works not like i want
  #needs to show total as label on each bar
  #each bar should be titled seperately
  #defaul (old method not using helper) is ok but can't change color of bars differently
  def networth_data
    [
      {name: "Assets", data: {"NetWorth": current_user.accounts.assets}}, 
      {name: "Liabilities", data: {"NetWorth": current_user.accounts.liabilities}}
    ]
  end

end
