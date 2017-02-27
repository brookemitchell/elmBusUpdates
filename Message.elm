module Message exposing (..)

import Http


type Msg
    = TravelInfo (Result Http.Error (List Alert))


type alias Alert =
    { id : Int
    , alert : AlertInfo
    }


type alias AlertInfo =
    { cause : String
    , effect : String
    , level : String
    , description : String
    }
