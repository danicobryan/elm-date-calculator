module DateCalculatorApp exposing (..)
import Html exposing (Html, body, input, text, h1, p, button)
import Html.Attributes exposing (style, value, type_)
import Html.Events exposing (onClick, onInput)
import Date exposing (..)
import Date.Extra as Date exposing (..)
import Result exposing (withDefault)
import Warmup exposing (daysBetween)


type alias Model = { date1: String, date2: String }
type Msg = ChangeDate1 String | ChangeDate2 String

daysBetweenMessage date1String date2String =
    let
      date1ToCheck = Date.fromString date1String
      date2ToCheck = Date.fromString date2String
    in
      case (date1ToCheck, date2ToCheck) of
          (Ok d1, Ok d2) -> "is " ++ toString (withDefault (0) (daysBetween date1String date2String)) ++ " days."
          (Err s, _) -> " days."
          (_, Err s) -> " days."

main =
    Html.beginnerProgram { model = model, view = view, update = update }

model : Model
model = { date1 = "", date2 = ""}

update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeDate1 d1 -> { model | date1 = d1 }
        ChangeDate2 d2 -> { model | date2 = d2 }

view : Model -> Html Msg
view model =
    body [style [("textAlign", "center"), ("font", "16px Arial"), ("background-color", "linen"), ("margin", "0")]]
        [ h1 [style [("background-color", "cyan")]] [text "Date Calculator"]
        , p [] [text "From: ", input [style [("border", "2px solid grey"), ("margin-left", "8px")], type_ "date", onInput ChangeDate1, value model.date1] []]
        , p [] [text "To: ",  input [type_ "date", onInput ChangeDate2, value model.date2] []]
        , p [] [text <| daysBetweenMessage model.date1 model.date2]
        ]
