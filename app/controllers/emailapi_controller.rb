class EmailapiController < ApplicationController

def index

end

def subscribe

  @list_id = "b7146ccd68"
    gb = Gibbon::API.new

    gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
      })
      redirect_to :back
      flash[:notice] = "You successfully subscribed"


end




end
