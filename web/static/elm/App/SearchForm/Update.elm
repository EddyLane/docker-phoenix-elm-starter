module App.SearchForm.Update exposing (..)

import App.SearchForm.Model exposing (Model, spotifyTrackDecoder, debounceConfig)
import App.SearchForm.Msg exposing (..)
import Json.Decode as Decode exposing (decodeValue)
import App.Msg as BaseMsg
import Http
import Debounce exposing (Debounce)

searchSpotify : String -> Cmd BaseMsg.Msg
searchSpotify term =
    let
        url =
            "https://api.spotify.com/v1/search?type=track&q=" ++ Http.encodeUri (term)

        request =
            Http.get url
                (Decode.list spotifyTrackDecoder
                    |> Decode.at [ "items" ]
                    |> Decode.at [ "tracks" ]
                )
    in
        Http.send (\result -> SearchResults result |> BaseMsg.MsgForSearchForm) request

update : Msg -> Model -> Model
update msg searchForm =
    case msg of
        UpdateSearch term ->
            { searchForm | term = term }


        DebounceMsg msg ->
          let
            (debounce, cmd) =
              Debounce.update
                debounceConfig
                (Debounce.takeLast searchSpotify)
                msg
                searchForm.debounce
          in
            { searchForm | debounce = debounce } ! [ cmd ]

        SearchResults (Ok results) ->
            { searchForm | results = results, error = Nothing }

        SearchResults (Err err) ->
            let
                message =
                    case err of
                        Http.Timeout ->
                            "Timeout"

                        Http.BadUrl _ ->
                            "BadUrl"

                        Http.NetworkError ->
                            "NetworkError"

                        Http.BadStatus _ ->
                            "BadStatus"

                        Http.BadPayload _ _ ->
                            "BadPayload"
            in
                { searchForm | error = Just message }

updateCmd : Msg -> Cmd BaseMsg.Msg
updateCmd msg =
    Cmd.none