Rails.application.routes.draw do

    scope "/:locale", locale: /#{I18n.available_locales.join('|')}/ do


                    root 'page#index'

                    # PAGES
                    get 'entreprise', to: "page#entreprise"
                    get 'equipe', to: "page#equipe"

                    # Pages > Carriere
                    get 'carrieres', to: "page#carrieres"
                    get 'poste', to: "page#fiche_poste"

                    get 'candidature', to: "page#candidature"
                    post 'candidature', to: "contact#candidature_send", as: "candidature_send"
                    get 'candidature-spontanee', to: "page#candidature_spontanee"
                    post 'candidature-spontanee', to: "contact#candidature_spontanee_send", as: "candidature_spontanee_send"

                    # Contact
                    get 'contact/success', to: "contact#success"
                    get 'contact/error', to: "contact#error"
                    get 'contact', to: "contact#general"
                    post 'contact/general', to: "contact#general_send", as:"general_send"

                    get 'contact/acquisition-equipement',   to: "contact#acquisition_equipement"
                    post 'contact/acquisition-equipement',  to: "contact#acquisition_equipement_send",  as:"acquisition_equipement_send"
                    get 'contact/inspection-technique',     to: "contact#inspection_technique"
                    post 'contact/inspection-technique',    to: "contact#inspection_technique_send",    as:"inspection_technique_send"

                    get 'contact/evaluation-equipement',    to: "contact#evaluation_equipement"
                    post 'contact/evaluation-equipement',   to: "contact#evaluation_equipement_send",    as:"evaluation_equipement_send"

                    get 'contact/echange-equipement/(:id)', to: "contact#echange_equipement", as: "contact/echange/equipement/"
                    post 'contact/echange-equipement/(:id)',   to: "contact#echange_equipement_send",    as:"echange_equipement_send"


                    get 'contact/ajustement-equipement/',   to: "contact#ajustement_equipement"
                    post 'contact/ajustement-equipement',   to: "contact#ajustement_equipement_send",   as:"ajustement_equipement_send"
                    get 'contact/demande-financement',      to: "contact#demande_financement"
                    post 'contact/demande-financement',     to: "contact#demande_financement_send",     as:"demande_financement_send"
                    post 'contact/estimation-transport',    to: "contact#estimation_transport_send",    as:"estimation_transport_send"
                    get 'contact/recherche-approfondie',    to: "contact#recherche_approfondie"
                    post 'contact/recherche-approfondie',   to: "contact#recherche_approfondie_send",    as:"recherche_approfondie_send"

                    # SERVICES

                    get 'services', to: "services#index"
                    get 'financement', to: "page#financement"

                    # Services > Pieces
                    get 'pieces', to:"services#pieces"
                    get 'pieces/commande-libre', to:"services#pieces_commande_libre"
                    post 'pieces/commande', to:"services#pieces_commande_send", as: "pieces/commande"
                    get 'pieces/recherche-approfondie', to:"services#pieces_recherche_approfondie"


                    # Services > equipements
                    get 'equipements', to:"services#equipements"
                    get 'equipements/neufs', to:"services#equipements_neufs"
                    get 'equipements/neufs/marques/', to:"services#equipements_neufs_marques", as: 'equipements/neufs/marques'
                    get 'equipements/neufs/marque/(:marque)/', to:"services#equipements_neufs_marque", as: 'equipements/neufs/marque'
                    get 'equipements/neufs/type/(:type)', to:"services#equipements_neufs_type", as: 'equipements/neufs/type'
                    get 'equipements/neufs/culture/(:culture)/', to:"services#equipements_neufs_culture", as: 'equipements/neufs/culture'
                    get 'equipements/usages', to:"services#equipements_usages"
                    get 'equipements/usages/evaluation', to:"services#equipements_usages_evaluation"
                    get 'equipements/usages/fiche/(:id)/(:marque)/(:annee)', to:"services#equipements_usages_fiche", as: 'equipements/usages/fiche'

                    # Services > expertise-conseil
                    get 'expertise', to:"services#expertise_conseil"
                    get 'expertise/acquisition-equipement', to:"services#acquisition_equipement"
                    get 'expertise/inspection-technique', to:"services#inspection_technique"
                    get 'expertise/ajustement-equipement', to:"services#ajustement_equipement"
                    get 'expertise/evaluation-equipement', to:"services#evaluation_equipement"

                    # Services > Transport
                    get 'transport', to:"services#transport"
                    get 'transport/transport-machinerie', to:"services#transport_machinerie", as: "transport/transport-machinerie"
                    get 'transport/transport-international', to:"services#transport_international", as: "transport/transport-international"
                    get 'transport/transport-hors-normes', to:"services#transport_hors_normes", as: "transport/transport-hors-normes"

                    # LANDING PAGES

                    get '/landing/(:year)/(:landing_page)/', to: "page#landing_page", as: 'landing'

        
        end

        root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

        # Redirection de toutes les URL avec la locale (FR|EN)
        get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302),
                      constraints: { path: /(?!(#{I18n.available_locales.join("|")})\/).*/, subdomain: '' },
                      format: false




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
