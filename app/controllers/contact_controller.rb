class ContactController < ApplicationController

    # --------------------------------------------------------------------------
    # Views
    # --------------------------------------------------------------------------

    def success
    end

    # --------------------------------------------------------------------------

    def error
    end

    # --------------------------------------------------------------------------
    def general
    end

    # --------------------------------------------------------------------------

    def acquisition_equipement
    end

    # --------------------------------------------------------------------------

    def echange_equipement
        @equipment = Equipment.with_attached_photos.find(message_params[:id])
    end

    # --------------------------------------------------------------------------

    def ajustement_equipement
    end

    # --------------------------------------------------------------------------

    def inspection_technique
    end

    # --------------------------------------------------------------------------

    def recherche_approfondie
    end

    # --------------------------------------------------------------------------

    def evaluation_equipement
    end

    # --------------------------------------------------------------------------

    def demande_financement
    end

    # --------------------------------------------------------------------------

    def estimation_transport
    end

    # --------------------------------------------------------------------------
    # Actions
    # --------------------------------------------------------------------------

    def general_send
        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        message: message_params[:message],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.general(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def acquisition_equipement_send
        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        forfait_acquisition: message_params[:forfait_acquisition],
                        type_equipement: message_params[:type_equipement],
                        message: message_params[:message],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.acquisition_equipement(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def inspection_technique_send
        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        forfait_inspection: message_params[:forfait_inspection],
                        message: message_params[:message],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.inspection_technique(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end
    # --------------------------------------------------------------------------

    def evaluation_equipement_send
        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        message: message_params[:message],
                        type_evaluation: message_params[:type_evaluation],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.evaluation_equipement(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end
    # --------------------------------------------------------------------------

    def echange_equipement_send
        @equipment = Equipment.find(message_params[:id])
        @message = {
                    equipment: @equipment,
                    name: message_params[:name],
                    email: message_params[:email],
                    phone: message_params[:phone],
                    marque_equipement_echange: message_params[:marque_equipement_echange],
                    modele_equipement_echange: message_params[:modele_equipement_echange],
                    annee_equipement_echange: message_params[:annee_equipement_echange],
                    heures_equipement_echange: message_params[:heures_equipement_echange],
                    prix_equipement_echange: message_params[:prix_equipement_echange],
                    ip_address: request.remote_ip,
        }
        if ContactMailer.echange_equipement(@message, @equipment.brand.name, @equipment.brand_model.name, @equipment.year).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def ajustement_equipement_send

        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        forfait_ajustement: message_params[:forfait_ajustement],
                        type_equipement: message_params[:type_equipement],
                        message: message_params[:message],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.ajustement_equipement(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def demande_financement_send
        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        message: message_params[:message],
                        forfait_financement: message_params[:forfait_financement],
                        type_equipement: message_params[:type_equipement],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.demande_financement(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def recherche_approfondie_send

        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        forfait_recherche: message_params[:forfait_recherche],
                        message: message_params[:message],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.recherche_approfondie(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def estimation_transport_send

        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        message: message_params[:message],
                        phone: message_params[:phone],
                        type_chargement: message_params[:type_chargement],
                        hors_normes: message_params[:hors_normes],
                        location_start: message_params[:location_start],
                        location_end: message_params[:location_end],
                        ip_address: request.remote_ip,
        }
        if ContactMailer.estimation_transport(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end
    end

    # --------------------------------------------------------------------------

    def candidature_send

        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        poste: message_params[:poste],
                        cv_candidature: message_params[:cv_candidature],
                        lettre_candidature: message_params[:lettre_candidature],
                        ip_address: request.remote_ip,
        }

        # Enregistrement des fichiers
        fichier_cv  = message_params[:cv_candidature]
        ext         = File.extname(fichier_cv.to_s)
        @message[:cv_filename]    = 'cv_'+ message_params[:name].underscore+"-"+Date.current.to_s+"-"+Time.now.to_i.to_s+ext
        File.open(Rails.root.join('public', 'uploads',@message[:cv_filename] ), 'wb') do |file|
           file.write(fichier_cv.read)
        end

        fichier_lettre  = message_params[:lettre_candidature]
        ext             = File.extname(fichier_lettre.to_s)
        @message[:lettre_filename]        = 'lettre_'+ message_params[:name].underscore+"-"+Date.current.to_s+"-"+Time.now.to_i.to_s+ext
        File.open(Rails.root.join('public', 'uploads', @message[:lettre_filename] ), 'wb') do |file|
           file.write(fichier_lettre.read)
        end

        if ContactMailer.candidature(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end

    end
    # --------------------------------------------------------------------------

    def candidature_spontanee_send

        @message = {
                        name: message_params[:name],
                        email: message_params[:email],
                        phone: message_params[:phone],
                        message: message_params[:message],
                        cv_candidature: message_params[:cv_candidature],
                        lettre_candidature: message_params[:lettre_candidature],
                        ip_address: request.remote_ip,
        }

        # Enregistrement des fichiers
        fichier_cv  = message_params[:cv_candidature]
        ext         = File.extname(fichier_cv.to_s)
        @message[:cv_filename]    = 'cv_'+ message_params[:name].underscore+"-"+Date.current.to_s+"-"+Time.now.to_i.to_s+ext
        File.open(Rails.root.join('public', 'uploads',@message[:cv_filename] ), 'wb') do |file|
           file.write(fichier_cv.read)
        end

        fichier_lettre  = message_params[:lettre_candidature]
        ext             = File.extname(fichier_lettre.to_s)
        @message[:lettre_filename]        = 'lettre_'+ message_params[:name].underscore+"-"+Date.current.to_s+"-"+Time.now.to_i.to_s+ext
        File.open(Rails.root.join('public', 'uploads', @message[:lettre_filename] ), 'wb') do |file|
           file.write(fichier_lettre.read)
        end

        if ContactMailer.candidature_spontanee(@message).deliver
            redirect_to contact_success_path
        else
            redirect_to contact_error_path
        end

    end

    # --------------------------------------------------------------------------
    # Private
    # --------------------------------------------------------------------------

    private


    def message_params
        params.permit(
            :id,
            :name,
            :email,
            :phone,
            :category,
            :message,
            :location_start,
            :location_end,
            :hors_normes,
            :type_chargement,
            :type_equipement,
            :poste,
            :cv_candidature,
            :lettre_candidature,
            :forfait_recherche,
            :forfait_ajustement,
            :type_equipement,
            :marque_equipement_echange,
            :modele_equipement_echange,
            :annee_equipement_echange,
            :heures_equipement_echange,
            :prix_equipement_echange,
            :forfait_inspection,
            :forfait_acquisition,
            :forfait_financement,
            :type_evaluation,
            :tos => [:accepted],
        )
    end

end
