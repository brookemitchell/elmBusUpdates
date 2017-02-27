module Main exposing (..)

import Html exposing (..)
import Message exposing (..)
import Requester exposing (travelInfo)
import Http


main =
    Html.program
        { init =
            ( initModel
            , travelInfo
            )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


initModel : Maybe (List Alert)
initModel =
    Nothing


update msg model =
    case msg of
        TravelInfo (Ok coolstuff) ->
            ( Just coolstuff
            , Cmd.none
            )

        TravelInfo (Err (Http.BadPayload errM _)) ->
            ( model
            , Cmd.none
            )

        TravelInfo (Err _) ->
            ( model
            , Cmd.none
            )


subscriptions model =
    Sub.none


view model =
    case model of
        Just alerts ->
            div []
                (List.map alertView alerts)

        Nothing ->
            div []
                [ text "Loading" ]


alertView al =
    div []
        [ div []
            [ al.id |> toString |> text
            ]
        , div []
            [ al.alert.description |> text
            ]
        ]
