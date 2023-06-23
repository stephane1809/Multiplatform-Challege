//
//  CKErrors.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 22/06/23.
//

import Foundation
import CloudKit

struct CKErrorDescription: LocalizedError, CustomStringConvertible {
    let localizedDescription: String
    let recoverySuggestion: String?
    
    var description: String {  return
        "\(localizedDescription) \(recoverySuggestion ?? "")"
    }
    
    init(localizedDescription: String, recoverySuggestion: String? = nil) {
        self.localizedDescription = localizedDescription
        self.recoverySuggestion = recoverySuggestion
    }
}

class CKErrorHandler {
    static func handleError(_ error: Error) -> Error {
        if let ckError = error as? CKError {
            switch ckError.code {
            case .internalError,
                    .partialFailure,
                    .serviceUnavailable,
                    .operationCancelled:
                return CKErrorDescription(
                    localizedDescription: "Ocorreu um problema interno!",
                    recoverySuggestion: "Reinicie o aplicativo e tente novamente. Se o problema persistir, entre em contato com o suporte em nossos canais de comunicação."
                )
                
            case .notAuthenticated,
                    .badContainer,
                    .missingEntitlement,
                    .permissionFailure,
                    .unknownItem,
                    .invalidArguments,
                    .resultsTruncated,
                    .serverRecordChanged,
                    .serverRejectedRequest,
                    .assetFileNotFound,
                    .incompatibleVersion,
                    .constraintViolation,
                    .changeTokenExpired,
                    .batchRequestFailed,
                    .badDatabase,
                    .quotaExceeded,
                    .zoneNotFound,
                    .limitExceeded,
                    .userDeletedZone,
                    .referenceViolation,
                    .assetNotAvailable,
                    .accountTemporarilyUnavailable:
                return CKErrorDescription(
                    localizedDescription: "Ocorreu um problema interno com o acesso aos dados!",
                    recoverySuggestion: "Reinicie o aplicativo, verifique se existe alguma atualização disponível e tente novamente. Se o problema persistir, entre em contato com o suporte em nossos canais de comunicação."
                )
                
            case .networkUnavailable,
                    .networkFailure:
                return CKErrorDescription(
                    localizedDescription: "Falha ao conectar com a Internet!",
                    recoverySuggestion: "Verifique sua conexão Wi-Fi ou dados móveis e tente novamente. Se o problema persistir, aguarde um pouco e tente novamente mais tarde."
                )
            case .requestRateLimited:
                return CKErrorDescription(
                    localizedDescription: "O limite máximo de requisições foi atingido!",
                    recoverySuggestion: "Tente novamente mais tarde"
                )

            case .zoneBusy:
                return CKErrorDescription(
                    localizedDescription: "O servidor apresentou problemas para lidar com a operação!",
                    recoverySuggestion: "Tente novamente em alguns segundos!"
                )
            case .tooManyParticipants:
                return CKErrorDescription(
                    localizedDescription: "A rede está muito ocupada.",
                    recoverySuggestion: "O número de usuários esxecede o número esperado, aguarde alguns instantes e tente novamente. Se o problema persistir, entre em contato com o suporte em nossos canais de comunicação."
                )
            case .alreadyShared:
                return CKErrorDescription(
                    localizedDescription: "A operação não pôde ser concluida pois o registro já foi compartilhado!"
                )

            case .managedAccountRestricted:
                return CKErrorDescription(
                    localizedDescription: "A solicitação foi negada devido a uma restrição a conta!"
                )
            case .participantMayNeedVerification:
                return CKErrorDescription(
                    localizedDescription: "O usuário não está autorizado a verificar o item compartilhado!"
                )
            case .serverResponseLost:
                return CKErrorDescription(
                    localizedDescription: "Conexão com o servidor foi perdida!",
                    recoverySuggestion: "Aguarde alguns minutos e tente novamente."
                )
            case .assetFileModified:
                return CKErrorDescription(
                    localizedDescription: "Os dados estão desatualizados!",
                    recoverySuggestion: "Arquivo foi alterado enquanto estava sendo obtido, atualize a página para atualizar os dados!"
                )
            @unknown default:
                return CKErrorDescription(
                    localizedDescription: "Erro não mapeado!",
                    recoverySuggestion: "Verifique se existe alguma atualização do aplicativo disponível e tente novamente."
                )
            }
        }
        return error
    }
}
