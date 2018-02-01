port module Ports exposing (..)

port initRecaptcha : String -> Cmd msg

port setRecaptchaToken : (String -> msg) -> Sub msg

port resetRecaptcha : () -> Cmd msg

