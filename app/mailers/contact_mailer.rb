class ContactMailer < ApplicationMailer

    def notification_ti(sujet, message)
        @message = message
        @sujet = sujet
        mail(to: "aymeric@lavoie.ag", subject: "Notification TI : " + sujet)
    end

    def general(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Général")
    end

    def acquisition_equipement(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Acquisition d'équipement")
    end

    def inspection_technique(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Inspection technique")
    end
    def evaluation_equipement(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Evaluation d'équipement")
    end

    def ajustement_equipement(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Ajustement d'équipement")
    end

    def echange_equipement(message, marque, modele, annee)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Échange d'équipement pour : "+ marque + " - " + modele + " - année " + annee.to_s)
    end

    def demande_financement(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Demande de financement")
    end

    def estimation_transport(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Estimation de transport")
    end

    def recherche_approfondie(message)
        @message = message
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Recherche approfondie")
    end

    def candidature(message)
        @message = message
        attachments[message[:cv_filename]] = File.read("#{Rails.root}/public/uploads/" + message[:cv_filename] )
        attachments[message[:lettre_filename]] = File.read("#{Rails.root}/public/uploads/" + message[:lettre_filename] )
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Candidature : " + message[:poste])
    end

    def candidature_spontanee(message)
        @message = message
        attachments[message[:cv_filename]] = File.read("#{Rails.root}/public/uploads/" + message[:cv_filename] )
        attachments[message[:lettre_filename]] = File.read("#{Rails.root}/public/uploads/" + message[:lettre_filename] )
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Candidature Spontanée")
    end

    def commande_libre(message,parts_order)
        @message        = message
        @parts_order    = parts_order
        mail(to: "aymeric@lavoie.ag", subject: "Contact site web - Commande libre")
    end

end
