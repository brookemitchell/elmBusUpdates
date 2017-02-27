module Requester exposing (travelInfo)

import Http
import Json.Decode exposing (..)
import Message exposing (Msg, Alert, AlertInfo)


-- import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


travelInfo : Cmd Msg
travelInfo =
    { method = "GET"
    , headers =
        [ (Http.header
            "Ocp-Apim-Subscription-Key"
            "3c74bb46a9734db1b6577568d26448ed"
          )
        ]
    , url = "https://api.at.govt.nz/v2/public/realtime/servicealerts"
    , body = Http.emptyBody
    , expect =
        at [ "response", "entity" ] (list tripDecoder)
            |> Http.expectJson
    , timeout = Nothing
    , withCredentials = False
    }
        |> Http.request
        |> Http.send Message.TravelInfo


tripDecoder =
    Json.Decode.map2
        Alert
        (at [ "id" ] int)
        (at [ "alert" ]
            (map4
                AlertInfo
                (at [ "cause" ] string)
                (at [ "effect" ] string)
                (at [ "level" ] string)
                (at [ "description_text", "translation", "0", "text" ] string)
            )
        )
