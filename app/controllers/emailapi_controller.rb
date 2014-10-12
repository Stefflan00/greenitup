class EmailapiController < ApplicationController

def index

end

def subscribe
  @list_id = "b7146ccd68"
  gb = Gibbon::API.new
  email = params[:email][:address]
  begin
    gb.lists.subscribe({
      :id => @list_id,
      :email => {:email => params[:email][:address]}
      })
    respond_to do |format|
      format.html {redirect_to emailapi_last_step_path, notice: "It is not done yet. Please check your Inbox and Confirm!"}
    end
  rescue Gibbon::MailChimpError => e
    if e.code == 214
      flash[:error] = "#{email} ist bereits in der Newsletterliste"
      redirect_to root_path
    else
      flash[:error] = "Sorry there was an error while subscribing:#{email} #{e.message} #{e.code} :("
      redirect_to root_path
    end
  end
end

def do_unsubscribe

end

def unsubscribe
  @list_id = "b7146ccd68"
  gb = Gibbon::API.new
  email = params[:email][:address]

  begin
    gb.lists.unsubscribe(
      :id => @list_id,
      :email => {:email => email},
      :delete_member => true,
      :send_notify => true)
      redirect_to emailapi_too_bad_path, notice: "Erfolgreich vom Newsletter abgemeldet"

  rescue Gibbon::MailChimpError => e

    if e.code == 232
      flash[:error] = "Die Email-Adresse: #{email} ist nicht in der Newsletterliste"
      redirect_to :back
    else
      flash[:error] = "#{e.message} #{e.code}"
      redirect_to root_path
    end

  end

end





def last_step
end


end
