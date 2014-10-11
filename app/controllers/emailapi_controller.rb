class EmailapiController < ApplicationController

def index

end

def subscribe

  @list_id = "b7146ccd68"
  gb = Gibbon::API.new
  begin
    gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
      })
    respond_to do |format|
      format.html {redirect_to emailapi_last_step_path, notice: "It is not done yet. Please check your Inbox and Confirm!"}
    end
  rescue Gibbon::MailChimpError => e
    render "index"
    flash[:error] = "Sorry there was an error while subscribing: #{e.message} :("
  end

end

def last_step
end


end
