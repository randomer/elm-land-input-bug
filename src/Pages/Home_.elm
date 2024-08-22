module Pages.Home_ exposing (Model, Msg, page)

import Html
import Html.Attributes as HA
import Html.Events as HE

import Effect exposing (Effect)
import Page exposing (Page)
import Route exposing (Route)
import Shared
import Shared.Msg
import View exposing (View)


type alias Model =
    { text : String
    }

type Msg
    = OnInput String
    | OnSharedInput String

page : Shared.Model -> Route () -> Page Model Msg
page shared _ =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view shared
        }

init : () -> (Model, Effect Msg)
init () =
    ( { text = "Page model" }
    , Effect.none
    )

update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        OnInput newText ->
            ( { model | text = newText }
            , Effect.none
            )
        OnSharedInput newText ->
            ( model
            , Effect.SendSharedMsg <|
                Shared.Msg.OnInput newText
            )

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

view : Shared.Model -> Model -> View Msg
view shared model =
    { title = "Homepage"
    , body =
        [ Html.div
            [ HA.style "font-size" "18px" ]
            [ Html.text "Set the caret in the middle of an input field and start typing. The page model field works normally, but the shared model field makes the cursor jump to the end on each keystroke."
            ]
        , Html.input
            [ HA.value model.text
            , HE.onInput OnInput
            ]
            []
        , Html.input
            [ HA.value shared.text
            , HE.onInput OnSharedInput
            ]
            []
        ]
    }
