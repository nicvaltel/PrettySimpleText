{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Domain.Server where

import ClassyPrelude
import Text.StringRandom (stringRandomIO)

newtype UserId = UserId {unUserId :: Int}
  deriving (Show, Eq, Ord, Num)

newtype SessionId = SessionId {unSessionId :: Text}
  deriving (Show, Eq, Ord)

data SessionError = 
    SessionErrorUnexpected
    deriving(Show, Eq, Ord)

newtype SessionData = SessionData
  { _sdMayUserId :: Maybe UserId -- Nothing for guest
  }


class Monad m => SessionRepo m where
  newSession :: Maybe UserId -> SessionId -> m () -- Maybe UserId is Nothing for guest
  getSessionData :: SessionId -> m (Maybe SessionData)
  debugGetAllSessions :: m (Map SessionId SessionData)



type LengthOfSessionId = Int -- usually = 32

generateNewSessionId :: MonadIO m => LengthOfSessionId -> m SessionId
generateNewSessionId lenSid = do
  let randLen = tshow lenSid
  sId <- liftIO $ stringRandomIO ("[A-Za-z0-9]{" <> randLen <> "}")
  pure (SessionId sId)