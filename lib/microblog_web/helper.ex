defmodule MicroblogWeb.Helper do 

  def is_admin?(user) do
     
    if user != nil do 
	user.is_admin?
    else 
	false
    end
  end


end
