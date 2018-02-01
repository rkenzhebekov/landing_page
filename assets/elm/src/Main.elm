module Main exposing (main)

import Ports
import Html exposing (Html)

import Messages exposing (Msg(..))
import Model exposing (..)
import Update exposing (update)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

init : ( Model, Cmd Msg )
init =
    initialModel ! [ Ports.initRecaptcha "recaptcha" ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.setRecaptchaToken SetRecaptchaToken
