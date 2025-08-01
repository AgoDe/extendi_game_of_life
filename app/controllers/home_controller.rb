class HomeController < ApplicationController
  def index
  end

  def start_game
    if params[:file].present?
      uploaded_file = params[:file]
      
      # Validazione del file
      if uploaded_file.content_type != 'text/plain'
        flash[:alert] = "Il file deve essere un file di testo (.txt)"
        redirect_to root_path and return
      end
      
      if uploaded_file.size > 1.megabyte
        flash[:alert] = "Il file non può essere più grande di 1MB"
        redirect_to root_path and return
      end
      
      # Salva il contenuto in sessione e reindirizza alla pagina game
      session[:file_content] = uploaded_file.read
      flash[:notice] = "File caricato con successo!"
      redirect_to game_path
    else
      flash[:alert] = "Devi selezionare un file"
      redirect_to root_path
    end
  end

  def game
    # Recupera il contenuto del file dalla sessione
    @file_content = session[:file_content]
    
    if @file_content.nil?
      flash[:alert] = "Nessun file caricato"
      redirect_to root_path
    end
  end
end
