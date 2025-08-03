class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end

  def start_game
    if params[:file].present?
      uploaded_file = params[:file]
      
      if uploaded_file.content_type != 'text/plain'
        flash[:alert] = "Il file deve essere un file di testo (.txt)"
        redirect_to root_path and return
      end
      
      if uploaded_file.size > 1.megabyte
        flash[:alert] = "Il file non può essere più grande di 1MB"
        redirect_to root_path and return
      end
      
      file_content = uploaded_file.read
      flash[:notice] = "File caricato con successo!"
      redirect_to game_path(file_content: Base64.strict_encode64(file_content))

    else
      flash[:alert] = "Devi selezionare un file"
      redirect_to root_path
    end
  end

  def game
    if params[:file_content].present?
      @file_content = Base64.decode64(params[:file_content]).force_encoding('UTF-8')
      @game_service = GameService.new(@file_content)
    else
      flash[:alert] = "Nessun file caricato"
      redirect_to root_path
    end
  end
end
