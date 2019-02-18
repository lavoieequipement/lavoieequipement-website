class PageController < ApplicationController


    def index
    end

    # A PROPOS
    # --------------------------------------------------------------------------

    def entreprise
    end

    def equipe
    end

    # CARRIERES
    # --------------------------------------------------------------------------

    def carrieres
    end

    def fiche_poste
    end

    def candidature
    end

    def candidature_spontanee
    end

    def candidature_spontanee_send
    end

    # FINANCEMENT
    # --------------------------------------------------------------------------

    def financement
    end

    # LANDING PAGE
    # --------------------------------------------------------------------------

    def landing_page
        render 'landing/' + params[:year] + '/'+ params[:landing_page].to_s.underscore rescue redirect_to root_url
    end


end
