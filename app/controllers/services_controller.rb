class ServicesController < ApplicationController

    def index
    end

    # EXPERTISE-CONSEIL
    # --------------------------------------------------------------------------

    def expertise_conseil
        render "services/expertise/expertise_conseil"
    end

    def acquisition_equipement
        render "services/expertise/acquisition_equipement"
    end

    def inspection_technique
        render "services/expertise/inspection_technique"
    end

    def ajustement_equipement
        render "services/expertise/ajustement_equipement"
    end
    def evaluation_equipement
        render "services/expertise/evaluation_equipement"
    end

    # EQUIPEMENT
    # --------------------------------------------------------------------------

    def equipements
        render "services/equipements/equipements"
    end

    # Equipements neufs

    def equipements_neufs
        render "services/equipements/equipements_neufs"
    end

    def equipements_neufs_marques
        render "services/equipements/equipements_neufs"
    end
    def equipements_neufs_marque
        @marque = params[:marque]
        render "services/equipements/marques/fiche_marque" rescue equipements_neufs_marques
    end

    def equipements_neufs_type
        @type = params[:type]
        render "services/equipements/types/fiche_type" rescue equipements_neufs
    end

    def equipements_neufs_culture
        @culture = params[:culture]
        render "services/equipements/cultures/culture_" + @culture rescue equipements_neufs
    end

    # Equipements usagés

    def equipements_usages
        if params.has_key?(:search) && !params[:search].empty? || params.has_key?(:brand) && !params[:brand].empty?
            @equipments = Equipment.with_attached_photos.search(params[:brand],params[:search].downcase)
            @search = true
        else
            @equipments = Equipment.with_attached_photos.all
            @search = false
        end

        render "services/equipements/equipements_usages"
    end

    def equipements_usages_fiche
        @equipment = Equipment.with_attached_photos.find(equipements_usages_params[:id])
        render "services/equipements/equipements_usages_fiche"
    end

    def equipements_usages_evaluation
        render "services/equipements/equipements_usages_evaluation"
    end

    # PIECES
    # --------------------------------------------------------------------------

    def pieces
        render "services/pieces/pieces"
    end

    def pieces_commande_libre

        @marques = Array.new
        @marques = {
                    'Macdon'            => "https://www.macdon.com/support/parts-catalogs",
                    'Horst'             => "http://horstwelding.ricambio.net/site/pagece5.wplus?ID_COUNT=ce_5_home&LN=2&CEPV=Horstwelding001&CELN=2&CEME=2&NDS=CE_1&PRF=1&PRNDS=R&PRC=%7CR%7CCE_1&KPRD=CE_1#CE_1",
                    #'Harvestmore'       => "#",
                    #'Grecav'            => "#",
                    'John Deere'        => "http://jdpc.deere.com/jdpc/servlet/com.deere.u90490.partscatalog.view.servlets.HomePageServlet_Alt?Origin=JDParts",
                    'New Holland'       => "https://partstore.agriculture.newholland.com/us/parts-search.html?csid=7d048ad87a81fc88052ed34ebfa8e724&sl=EN&currency=#epc::home",
                    'Claas'             => "http://www.claas.fr/service_pieces/catalogue/catalogue-des-pieces-de-rechange-parts-doc-online",
                    'Case IH'           => "https://partstore.caseih.com/us/index.php?target=epc_manuals_detail&sl=FR&csid=28171f8d6720eef273b5aff0affe2148&sl=FR&currency=#epc::home",
                    'Laverda'           => "https://ngpc.cnh.com/Lp/es/cbs?brand=NHAG&region=EUR&sma=&locale=fr",
                    'Schumacher'        => "https://www.argis2000.ca/schumacher-llc/",
                    'A&I'               => "https://www.allpartsstore.com/fr/index.htm?customernumber=PQ3773",
                    'Massey Ferguson'   => "http://www.agcopartsbooks.com/PartsBooksN/Login.aspx?ReturnUrl=%2fPartsBooksN%2fViewer%2fDefault.aspx",
                }

        @parts_order = PartsOrder.new
        @parts_order.parts_order_items.build
        render "services/pieces/pieces_commande_libre"
    end

    def pieces_commande_send

        @parts_order = PartsOrder.new(parts_order_params)
        if @parts_order.save

            # Envoi courriel au département des pièces
            @message = {
                            name: @parts_order.name,
                            email: @parts_order.email,
                            ip_address: request.remote_ip,
            }
            ContactMailer.commande_libre(@message,@parts_order).deliver
            render "services/pieces/confirmation_commande_libre"
        else
            # Envoi courriel au service TI
            ContactMailer.notification_ti("commande libre", "Impossible de sauvegarder la commande libre").deliver
            render "services/pieces/erreur_commande_libre"
        end

    end

    def pieces_recherche_approfondie
        render "services/pieces/pieces_recherche_approfondie"
    end


    # TRANSPORT
    # --------------------------------------------------------------------------

    def transport
        render "services/transport/transport"
    end

    def transport_machinerie
        render "services/transport/transport_machinerie"
    end

    def transport_international
        render "services/transport/transport_international"
    end

    def transport_hors_normes
        render "services/transport/transport_hors_normes"
    end

    # --------------------------------------------------------------------------
    # PRIVATE
    # --------------------------------------------------------------------------

    private

    def equipements_usages_params
        params.permit(:id)
    end

    def parts_order_params
        params.require(:parts_order).permit(
            :name,
            :email,
            :phone,
            parts_order_items_attributes: [:marque, :reference, :quantite, :_destroy])
    end

end
