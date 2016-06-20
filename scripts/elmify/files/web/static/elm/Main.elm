module Main exposing (main)

import Html exposing (..)
import Html.App as App

main : Program Never
main = App.program
  { init = init
  , subscriptions = subscriptions
  , update = update
  , view = view
  }

type Msg
  = NoOp

type alias Model =
  {
  }

init : (Model, Cmd Msg)
init = (Model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> Html Msg
view model = div [] [ text "Hello from Elm!" ]
